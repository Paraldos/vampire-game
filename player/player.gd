extends CharacterBody2D

@export var speed: float = 70.0

func _physics_process(_delta: float) -> void:
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