extends Sprite2D

@onready var animation_player_main: AnimationPlayer = %AnimationPlayerMain

@export var attack_time := 0.3
@export var lunge_distance := 5
@export var squeeze_strength := 0.25
var squeeze_time := attack_time / 4
var attacking = false

func attack_animation(target_pos: Vector2) -> void:
	if attacking: return
	var dir: Vector2 = target_pos - global_position
	if dir.length_squared() <= 0.1: return

	attacking = true
	animation_player_main.stop()

	dir = dir.normalized()
	_lunge_animation(dir * lunge_distance)
	_squeeze_animation(dir)

	await get_tree().create_timer(attack_time).timeout
	attacking = false
	animation_player_main.play("idle")

func _lunge_animation(lunge_pos: Vector2):
	var attack_tween: Tween
	var old_pos := global_position
	global_position += lunge_pos
	attack_tween = create_tween()
	attack_tween.tween_property(self, "global_position", old_pos, attack_time)

func _squeeze_animation(dir : Vector2):
	var old_scale := scale
	var squeeze := Vector2.ONE
	var squeeze_tween: Tween
	if abs(dir.x) > abs(dir.y):
		squeeze.x += squeeze_strength
		squeeze.y -= squeeze_strength
	else:
		squeeze.x -= squeeze_strength
		squeeze.y += squeeze_strength
	squeeze_tween = create_tween()
	squeeze_tween.tween_property(self, "scale", squeeze, squeeze_time)
	await squeeze_tween.finished
	squeeze_tween = create_tween()
	squeeze_tween.tween_property(self, "scale", old_scale, attack_time - squeeze_time)