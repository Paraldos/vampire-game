extends Node2D

@onready var main_sprite: Sprite2D = $MainSprite

var slot := -1
var is_hero := false
var character: Character

func _ready() -> void:
	main_sprite.flip_h = !is_hero
	if slot == -1:
		queue_free()
		return
	main_sprite.texture = character.combat_sprite
