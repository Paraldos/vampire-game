extends "res://exploration/interactables/templates/interactable.gd"

const FLOATING_MESSAGE = preload("uid://cakdlilotuy2i")
var open = false
@export var locked := false
@export var required_flags: Array[Flag]

func _can_be_opend() -> bool:
	if locked:
		return false
	for flag in required_flags:
		if not FlagsManager.has_flag(flag):
			return false
	return true

func _bumped():
	super()
	if _can_be_opend():
		open = !open
		main_sprite.frame += 1 if open else -1
		bumper.set_enabled(!open)
	else:
		Utils.spawn_floating_message('Door locked', global_position)
