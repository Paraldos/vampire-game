extends CharacterBody2D

@export var speed: float = 150.0
var is_moving := false

func _physics_process(delta: float) -> void:
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input = input.normalized()
	velocity = input * speed
	move_and_slide()
