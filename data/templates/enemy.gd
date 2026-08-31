extends Resource
class_name Enemy

@export var name: String
@export var actions: Array[Action]

@export_group('display')
@export var group = false
@export var sprites : Array[Texture2D]

@export_group('stats')
@export var max_hp := 10
@export_storage var current_hp := max_hp
@export var attack = 5
@export var defense = 5

func get_random_sprite() -> Texture2D:
	if sprites.is_empty():
		return null
	return sprites.pick_random()

func get_attack():
	return attack

func get_defense():
	return defense
