extends Node2D

var rng = RandomNumberGenerator.new()
signal finished

func _ready() -> void:
	rng.randomize()
	for child in get_children():
		child.visible = false

func play():
	var sprit : AnimatedSprite2D = get_child(rng.randi_range(0, get_child_count() -1))
	sprit.visible = true
	sprit.play()
	await sprit.animation_finished
	sprit.visible = false
	finished.emit()
