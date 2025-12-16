extends Node2D

@onready var main_sprite: Sprite2D = %MainSprite
@onready var animation_player_main: AnimationPlayer = %AnimationPlayerMain

@onready var sword_animation: Node2D = %SwordAnimation
@onready var hitbox: Hitbox = $Hitbox

@onready var movement_helper: Node2D = %MovementHelper

var path : Array[Vector2]
var movement_target: Vector2
var speed := 80.0
var moving := false
var target_enemy : Enemy
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	SignalController.left_click_enemy.connect(_on_left_click_enemy)
	SignalController.left_clicked_floor.connect(_on_left_clicked_floor)

func _on_left_clicked_floor(target_cell):
	if Input.is_action_pressed('shift'):
		_shift_click()
	else:
		var tile_path = movement_helper.get_tile_path(target_cell)
		path = movement_helper.tile_path_to_cell_path(tile_path)
		target_enemy = null

func _on_left_click_enemy(enemy : Enemy):
	if Input.is_action_pressed('shift'):
		_shift_click()
	else:
		path = movement_helper.get_path_to_target(enemy.global_position)
		target_enemy = enemy

func _shift_click():
	var target_cell = movement_helper.pos_to_cell(get_global_mouse_position())
	var target_position = movement_helper.cell_to_pos(target_cell)
	_attack(target_position)

func _physics_process(delta: float) -> void:
	if not moving and target_enemy and movement_helper._target_is_neighbour(target_enemy.global_position):
			_attack(target_enemy.global_position)
	if not moving and path.size() > 0:
		movement_target = path.pop_front()
		moving = true
	if moving:
		_move(delta)

func _attack(target_position : Vector2):
	sword_animation.look_at(target_position + Vector2(8,8))
	sword_animation.play()
	animation_player_main.play('attack')
	hitbox.look_at(target_position + Vector2(8,8))
	hitbox.enable()
	target_enemy = null

func _move(delta: float) -> void:
	global_position = global_position.move_toward(movement_target, speed * delta)
	if global_position.x < movement_target.x and main_sprite.flip_h == false:
		main_sprite.flip_h = true
	if global_position.x > movement_target.x and main_sprite.flip_h == true:
		main_sprite.flip_h = false
	if global_position.distance_to(movement_target) < 0.01:
		global_position = movement_target
		moving = false
