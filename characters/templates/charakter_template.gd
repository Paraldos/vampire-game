extends Node2D
class_name CharacterTemplate

@export var visible_path: bool = true
@export var speed: float = 60.0
var path: Array[Vector2i] = []:
	set(new_path):
		path = new_path
		if visible_path:
			Utils.add_visible_path(path)
var movement_target_pos: Vector2 = Vector2.ZERO
var movement_target_cell: Vector2i = Vector2i(-9999, -9999)
var moving: bool = false
var rng := RandomNumberGenerator.new()
var occupied_cell: Vector2i

func _ready() -> void:
	rng.randomize()
	occupied_cell = Utils.pos_to_cell(global_position)
	Utils.map.astar_grid.set_point_solid(occupied_cell, true)

func _physics_process(_delta: float) -> void:
	pass

func _start_moving(target_cell: Vector2i) -> void:
	if Utils.map.astar_grid.is_point_solid(target_cell): return
	moving = true
	movement_target_pos = Utils.cell_to_pos(target_cell)
	movement_target_cell = target_cell
	Utils.map.astar_grid.set_point_solid(movement_target_cell, true)

func _end_moving() -> void:
	Utils.map.astar_grid.set_point_solid(occupied_cell, false)
	occupied_cell = Utils.pos_to_cell(global_position)
	movement_target_cell = Vector2i(-9999, -9999)
	moving = false

func cancel_move(teleport_back: bool = false) -> void:
	if movement_target_cell != Vector2i(-9999, -9999):
		Utils.map.astar_grid.set_point_solid(movement_target_cell, false)
		movement_target_cell = Vector2i(-9999, -9999)
	if teleport_back:
		global_position = Utils.cell_to_pos(occupied_cell)
	moving = false
	path.clear()

func move(delta: float) -> void:
	global_position = global_position.move_toward(movement_target_pos, speed * delta)
	if global_position.distance_to(movement_target_pos) <= 0.5:
		global_position = movement_target_pos
		_end_moving()

func _exit_tree() -> void:
	cancel_move(false)
	Utils.map.astar_grid.set_point_solid(occupied_cell, false)
