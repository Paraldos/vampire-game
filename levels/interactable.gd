extends Node2D

@onready var main_sprite: Sprite2D = $MainSprite
@onready var bumper: Bumper = $Bumper
var open = false

func _on_bumper_bumped() -> void:
	_toggle()

func _toggle():
	open = !open
	main_sprite.frame += 1 if open else -1
	bumper.set_enabled(!open)
