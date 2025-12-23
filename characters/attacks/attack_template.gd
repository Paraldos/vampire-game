extends Node2D
class_name AttackAnimation

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	for child in get_children():
		child.visible = false

func play(target_pos : Vector2):
	look_at(target_pos)
	# start sprite
	var sprit : AnimatedSprite2D = get_child(rng.randi_range(0, get_child_count() -1))
	sprit.visible = true
	sprit.play()
	# cleanup
	await sprit.animation_finished
	sprit.visible = false
	return
