extends Node2D

@onready var main_sprite: Sprite2D = %MainSprite
@onready var animation_player_main: AnimationPlayer = %AnimationPlayerMain
@onready var sword_animation: Node2D = %SwordAnimation
@onready var hitbox: Hitbox = $Hitbox
@onready var character_helper: Node2D = $CharacterHelper

var path : Array[Vector2i]
var visible_path = false
var movement_target: Vector2
var speed := 80.0
var moving := false
var target_enemy : Enemy
var rng = RandomNumberGenerator.new()
var attacking = false
var player_cell : Vector2i :
	get: return Utils.pos_to_cell(global_position)

func _ready() -> void:
	rng.randomize()
	SignalController.left_click_enemy.connect(_on_left_click_enemy)
	SignalController.left_clicked_floor.connect(_on_left_clicked_floor)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('left_click') and Input.is_action_pressed('shift'):
		_shift_click()
	if not moving and target_enemy and character_helper._target_is_neighbour(target_enemy.global_position):
		_attack(target_enemy.global_position  + Vector2(8,8))
		target_enemy = null
	if not moving and path.size() > 0:
		movement_target = Utils.cell_to_pos(path.pop_front())
		moving = true
	if moving:
		_move(delta)

func _on_left_clicked_floor(target_cell):
	if Input.is_action_pressed('shift'): return
	if attacking: return
	path = Utils.get_astar_path(player_cell, target_cell)
	if moving: path.pop_front()
	target_enemy = null
	if visible_path:
		Utils.add_visible_path(path)

func _on_left_click_enemy(enemy : Enemy):
	if Input.is_action_pressed('shift'): return
	if attacking: return
	path = character_helper.get_path_to_target(enemy.global_position)
	if visible_path:
		Utils.add_visible_path(path)
	target_enemy = enemy

func _shift_click():
	if attacking: return
	_attack(get_global_mouse_position())

func _attack(target_position : Vector2):
	attacking = true
	hitbox.look_at(target_position)
	hitbox.enable()
	animation_player_main.play('attack')
	sword_animation.look_at(target_position)
	sword_animation.play()
	await sword_animation.finished
	attacking = false

func _move(delta: float) -> void:
	global_position = global_position.move_toward(movement_target, speed * delta)
	if global_position.x != movement_target.x:
		main_sprite.flip_h = global_position.x > movement_target.x
	if global_position.distance_to(movement_target) < 0.01:
		global_position = movement_target
		moving = false
