extends "res://exploration/interactables/templates/interactable.gd"

var open = false

func _bumped():
	super()
	open = !open
	main_sprite.frame += 1 if open else -1
	bumper.set_enabled(!open)
