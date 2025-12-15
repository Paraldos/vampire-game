extends Node2D

@onready var movement_helper: Node2D = %MovementHelper

var path : Array[Vector2]
var current_target: Vector2
var speed := 80.0
var moving := false

func _ready() -> void:
	SignalController.left_click_enemy.connect(_on_left_click_enemy)
	SignalController.left_clicked_floor.connect(_on_left_clicked_floor)

func _physics_process(delta: float) -> void:
	if not moving and path.size() > 0:
		current_target = path.pop_front()
		moving = true
	if moving:
		_move(delta)

func _on_left_clicked_floor(target_cell):
	var tile_path = movement_helper.get_tile_path(target_cell)
	path = movement_helper.tile_path_to_cell_path(tile_path)

func _on_left_click_enemy(enemy : Enemy):
	path = movement_helper.get_path_to_target(enemy.global_position)

func _move(delta: float) -> void:
	global_position = global_position.move_toward(current_target, speed * delta)
	if global_position.distance_to(current_target) < 0.01:
		global_position = current_target
		moving = false
