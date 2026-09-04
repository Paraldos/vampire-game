extends Sprite2D
class_name DisplaySprite

var duration := 0.5
@export var player_display = true

func _ready() -> void:
	_fade_in()
	GlobalSignals.display_animation.connect(_on_display_animation)

func _on_display_animation(targets_player, animation, animation_duration) -> void:
	if targets_player != player_display:
		return
	duration = animation_duration
	match animation:
		Enums.ANIMATIONS.ATTACK:
			attack_animation()
		Enums.ANIMATIONS.HIT:
			hit_animation()
		_:
			pass

# ======================================================= animations
func _fade_in():
	modulate.a = 0
	var t = create_tween()
	t.tween_property(self, "modulate:a", 1.0, 0.3)

func attack_animation() -> void:
	var direction := 1.0 if player_display else -1.0
	var target := Vector2(20.0 * direction, 0.0)
	var tween := create_tween()
	tween.tween_property(
		self,
		"position",
		target,
		duration * 0.2
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		self,
		"position",
		Vector2.ZERO,
		duration * 0.8
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func hit_animation() -> void:
	var shake_steps := 8
	var step_duration := duration / shake_steps
	var shake_strength := 4.0

	var original_position := global_position
	var original_scale := scale
	var original_modulate := modulate

	var shake_tween := create_tween()
	for i in shake_steps - 1:
		var strength := shake_strength * (
			1.0 - float(i) / float(shake_steps - 1))
		var offset := Vector2(
			randf_range(-strength, strength),
			randf_range(-strength, strength))
		shake_tween.tween_property(
			self,
			"global_position",
			original_position + offset,
			step_duration
		)
	shake_tween.tween_property(
		self,
		"global_position",
		original_position,
		step_duration
	)

	# change color
	var flash_tween := create_tween()
	flash_tween.tween_property(
		self,
		"modulate",
		Color(1.0, 0.35, 0.35),
		duration * 0.1
	)
	flash_tween.tween_property(
		self,
		"modulate",
		original_modulate,
		duration * 0.3
	)

	# squeez
	var squash_tween := create_tween()
	squash_tween.tween_property(
		self,
		"scale",
		original_scale * Vector2(0.85, 1.15),
		duration * 0.1
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	squash_tween.tween_property(
		self,
		"scale",
		original_scale,
		duration * 0.3
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
