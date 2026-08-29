extends State

func physics_process(_delta: float) -> void:
	var direction := _get_input_direction()
	if direction == Vector2.ZERO: return
	actor.move_direction = direction
	if _is_blocked(direction):
		transition_to(&"Bump")
	else:
		transition_to(&"Move")

func _get_input_direction() -> Vector2:
	if Input.is_action_pressed("left"):
		return Vector2.LEFT
	if Input.is_action_pressed("right"):
		return Vector2.RIGHT
	if Input.is_action_pressed("up"):
		return Vector2.UP
	if Input.is_action_pressed("down"):
		return Vector2.DOWN
	return Vector2.ZERO

func _is_blocked(direction: Vector2) -> bool:
	match direction:
		Vector2.LEFT:
			return actor.left.is_colliding()
		Vector2.RIGHT:
			return actor.right.is_colliding()
		Vector2.UP:
			return actor.up.is_colliding()
		Vector2.DOWN:
			return actor.down.is_colliding()
	return false
