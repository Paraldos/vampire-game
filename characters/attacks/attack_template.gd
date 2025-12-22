extends Node2D

var rng = RandomNumberGenerator.new()
var target_pos := Vector2(-9999, -9999)
signal finished

func _ready() -> void:
	rng.randomize()
	for child in get_children():
		child.visible = false

func play(target_pos):
	look_at(target_pos)
	# start sprite
	var sprit : AnimatedSprite2D = get_child(rng.randi_range(0, get_child_count() -1))
	sprit.visible = true
	sprit.play()
	# cleanup
	await sprit.animation_finished
	sprit.visible = false
	finished.emit()
