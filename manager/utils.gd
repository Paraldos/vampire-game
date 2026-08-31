extends Node

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func clear_container(container : Control):
	for child in container.get_children():
		child.queue_free()

func roll_dice(sides := 6) -> int:
	var dice = rng.randi_range(1, sides)
	return dice
