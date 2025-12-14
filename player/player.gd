extends CharacterBody2D

@export var speed: float = 70.0
var current_path : Array[Vector2i]

func _physics_process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var player_tile = Utils.tile_map.local_to_map(global_position)
		var clicked_tile = Utils.tile_map.local_to_map(get_global_mouse_position())
		current_path = Utils.astar_grid.get_id_path(player_tile, clicked_tile)
		Utils._update_visible_path(current_path)
	var input = _get_input()
	_move(input)

func _get_input():
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input = input.normalized()
	return input

func _move(input: Vector2):
	velocity = input * speed
	move_and_slide()
