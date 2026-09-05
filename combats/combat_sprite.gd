@tool
extends Node2D
class_name CombatSprite

@onready var sprite: Sprite2D = %Sprite
@export var texture: Texture2D:
	set(value):
		texture = value
		if is_instance_valid(sprite):
			sprite.texture = value
@export var player_display = false:
	set(value):
		player_display = value
		if is_instance_valid(sprite):
			sprite.flip_h = !value
var duration := CombatAction.ACTION_DURATION

func _ready() -> void:
	GlobalSignals.display_animation.connect(_on_play_attack_animation)
	sprite.flip_h = !player_display
	sprite.texture = texture

func _on_play_attack_animation(animate_player: bool, animation_name : Enums.ANIMATIONS):
	if animate_player != player_display: return
	match animation_name:
		Enums.ANIMATIONS.ATTACK:
			play_attack()
		Enums.ANIMATIONS.HIT:
			play_hit()
		_:
			pass

func play_attack() -> void:
	var direction := 1.0 if player_display else -1.0
	var target := Vector2(20.0 * direction, 0.0)
	var tween := create_tween()
	tween.tween_property(
		sprite,
		"position",
		target,
		duration * 0.2
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		sprite,
		"position",
		Vector2.ZERO,
		duration * 0.8
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func play_hit() -> void:
	var original_position := sprite.position
	var original_scale := sprite.scale
	var original_modulate := sprite.modulate

	var shake_steps := 8
	var step_duration := duration / shake_steps
	var shake_strength := 4.0

	var shake_tween := create_tween()

	for i in shake_steps - 1:
		var strength := shake_strength * (
			1.0 - float(i) / float(shake_steps - 1)
		)

		var offset := Vector2(
			randf_range(-strength, strength),
			randf_range(-strength, strength)
		)

		shake_tween.tween_property(
			sprite,
			"position",
			original_position + offset,
			step_duration
		)

	shake_tween.tween_property(
		sprite,
		"position",
		original_position,
		step_duration
	)

	# change color
	var flash_tween := create_tween()
	flash_tween.tween_property(
		sprite,
		"modulate",
		Color(1.0, 0.35, 0.35),
		duration * 0.1
	)
	flash_tween.tween_property(
		sprite,
		"modulate",
		original_modulate,
		duration * 0.3
	)

	# squeez
	var squash_tween := create_tween()
	squash_tween.tween_property(
		sprite,
		"scale",
		original_scale * Vector2(0.85, 1.15),
		duration * 0.1
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	squash_tween.tween_property(
		sprite,
		"scale",
		original_scale,
		duration * 0.3
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
