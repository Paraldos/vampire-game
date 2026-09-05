extends State

const MOVEMENT_DURATION := 0.4
const RISE_DURATION := MOVEMENT_DURATION * 0.4
const FALL_DURATION := MOVEMENT_DURATION * 0.4
const JUMP_HEIGHT := 1.5

func start() -> void:
	var direction: Vector2 = actor.move_direction

	actor.global_position += direction * ExplorationManager.TILE_SIZE
	actor.sprite_parent.position -= direction * ExplorationManager.TILE_SIZE

	_animation_hop()
	await _animation_move()
	#await get_tree().create_timer(0.1).timeout

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
		RISE_DURATION
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		actor.sprite,
		"position:y",
		0.0,
		FALL_DURATION
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
