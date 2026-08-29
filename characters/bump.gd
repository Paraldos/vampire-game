extends State

const BUMP_DURATION := 0.3
const BUMP_REACH := 3.0

func start() -> void:
	await _animation_bump()
	transition_to(&"Idle")

func _animation_bump() -> void:
	var tween := create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(
		actor.sprite_parent,
		"position",
		actor.move_direction * BUMP_REACH,
		BUMP_DURATION / 2.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		actor.sprite_parent,
		"position",
		Vector2.ZERO,
		BUMP_DURATION / 2.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await tween.finished
