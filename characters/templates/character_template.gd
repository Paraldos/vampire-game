extends Node2D
class_name CharacterTemplate

@onready var state_machine: StateMachine = %StateMachine
@onready var character_sprite_container: Node2D = %CharacterSpriteContainer
@onready var hit_sprite: Sprite2D = $CharacterSpriteContainer/HitSprite
@onready var character_sprite: Sprite2D = %CharacterSprite

@onready var ranged_range_detector: RayCast2D = %RangedRangeDetector
@onready var melee_range_detector: Area2D = %MeleeRangeDetector

@export var speed: float = 50.0
@export var color_default = Color('a53030')
@export var color_hover = Color('cf573c')

var path: Array[Vector2i] = []:
	set(new_path):
		path = new_path
		# Utils.add_visible_path(path)
var movement_target_pos: Vector2 = Vector2.ZERO
var movement_target_cell: Vector2i = Vector2i(-9999, -9999)
var animating: bool = false
var rng := RandomNumberGenerator.new()
var occupied_cell: Vector2i
var attack_target : Enemy

# =================================== ready
func _ready() -> void:
	rng.randomize()
	occupied_cell = Utils.pos_to_cell(global_position)
	Utils.map.astar_grid.set_point_solid(occupied_cell, true)
	_change_color(color_default)
	_init_sprites()

func _init_sprites():
	hit_sprite.visible = false
	hit_sprite.hframes = character_sprite.hframes
	hit_sprite.vframes = character_sprite.vframes
	hit_sprite.frame = character_sprite.frame

# =================================== tree exit
func _exit_tree() -> void:
	cancel_move(false)
	Utils.map.astar_grid.set_point_solid(occupied_cell, false)

# =================================== helper
func _change_color(new_color : Color):
	var mat := character_sprite.material as ShaderMaterial
	mat.set_shader_parameter("new_color", new_color)

# =================================== movement
func start_moving() -> void:
	while not path.is_empty():
		var next_cell: Vector2i = path[0]
		if next_cell == occupied_cell:
			path.pop_front()
			continue
		if global_position.distance_to(Utils.cell_to_pos(next_cell)) <= 5.0:
			path.pop_front()
			continue
		break
	if path.is_empty(): return
	var target_cell: Vector2i = path.pop_front()
	if Utils.map.astar_grid.is_point_solid(target_cell):
		return
	animating = true
	movement_target_cell = target_cell
	movement_target_pos = Utils.cell_to_pos(target_cell)
	Utils.map.astar_grid.set_point_solid(movement_target_cell, true)

func stop_moving() -> void:
	Utils.map.astar_grid.set_point_solid(occupied_cell, false)
	occupied_cell = Utils.pos_to_cell(global_position)
	if movement_target_cell != Vector2i(-9999, -9999) and movement_target_cell != occupied_cell:
		Utils.map.astar_grid.set_point_solid(movement_target_cell, false)
	movement_target_cell = Vector2i(-9999, -9999)
	animating = false

func cancel_move(teleport_back: bool = false) -> void:
	if movement_target_cell != Vector2i(-9999, -9999):
		Utils.map.astar_grid.set_point_solid(movement_target_cell, false)
		movement_target_cell = Vector2i(-9999, -9999)
	if teleport_back:
		global_position = Utils.cell_to_pos(occupied_cell)
	animating = false
	path.clear()

func _is_next_step_valid() -> bool:
	if path.is_empty():
		return false
	var next_cell: Vector2i = path[0]
	if not Utils.map.astar_grid.region.has_point(next_cell):
		return false
	if Utils.map.astar_grid.is_point_solid(next_cell):
		return false
	return true

func move(delta: float) -> void:
	global_position = global_position.move_toward(movement_target_pos, speed * delta)
	if global_position.distance_to(movement_target_pos) <= 0.5:
		global_position = movement_target_pos
		stop_moving()
