extends Node2D

@onready var main_sprite: Sprite2D = $MainSprite
@onready var active_indicator: Sprite2D = %ActiveIndicator

var slot := -1
var is_hero := false
var character: Character

func _ready() -> void:
	GlobalSignals.activate_character.connect(_on_activate_character)
	if is_hero:
		scale *= 1.2
	else:
		main_sprite.flip_h = true
	if slot == -1:
		queue_free()
		return
	main_sprite.texture = character.combat_sprite
	active_indicator.visible = CombatManager.get_active_character() == character

func _on_activate_character(activted_character : Character):
	active_indicator.visible = activted_character == character
