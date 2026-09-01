extends State

const MOVEMENT_DURATION := 0.4
const JUMP_HEIGHT := 1.0

func start() -> void:
	var direction: Vector2 = actor.move_direction

	actor.global_position += direction * LevelManager.TILE_SIZE
	actor.sprite_parent.position -= direction * LevelManager.TILE_SIZE

	_animation_hop()
	await _animation_move()

	transition_to(&"Idle")

func _animation_move() -> void:
	var tween := create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(
		actor.sprite_parent,
		"position",
		Vector2.ZERO,
		MOVEMENT_DURATION
	).set_trans(Tween.TRANS_SINE)
	await tween.finished
	return

func _animation_hop() -> void:
	var tween := create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(
		actor.sprite,
		"position:y",
		-JUMP_HEIGHT,
		MOVEMENT_DURATION / 2.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		actor.sprite,
		"position:y",
		0.0,
		MOVEMENT_DURATION / 2.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
