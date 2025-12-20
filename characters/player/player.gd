extends CharacterTemplate

@onready var character_sprite_container: Node2D = %CharacterSpriteContainer
@onready var character_sprite: Sprite2D = %CharacterSprite
@onready var sword_animation: Node2D = %SwordAnimation
@onready var hitbox: Hitbox = $Hitbox
@onready var character_helper: Node2D = $CharacterHelper

var target_enemy
var attacking = false

func _ready() -> void:
	super()
	SignalController.left_click_enemy.connect(_on_left_click_enemy)
	SignalController.left_clicked_floor.connect(_on_left_clicked_floor)

func _physics_process(delta: float) -> void:
	super(delta)
	if Input.is_action_pressed('left_click') and Input.is_action_pressed('shift'):
		_shift_click()
	if not moving and target_enemy and character_helper._target_is_neighbour(target_enemy.global_position):
		_attack(target_enemy.global_position  + Vector2(8,8))
		target_enemy = null

func _on_left_clicked_floor(target_cell):
	if Input.is_action_pressed('shift'): return
	if attacking: return
	path = Utils.get_astar_path(occupied_cell, target_cell)
	if moving: path.pop_front()
	target_enemy = null

func _on_left_click_enemy(enemy):
	if Input.is_action_pressed('shift'): return
	if attacking: return
	path = character_helper.get_path_to_target(enemy.global_position)
	target_enemy = enemy

func _shift_click():
	if attacking: return
	_attack(get_global_mouse_position())

func _attack(target_position : Vector2):
	attacking = true
	character_sprite.attack_animation(target_position)
	hitbox.look_at(target_position)
	hitbox.enable()
	sword_animation.look_at(target_position)
	sword_animation.play()
	await sword_animation.finished
	attacking = false
