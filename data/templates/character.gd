extends Resource
class_name Character

@export var name: String
@export var combat_sprite: Texture2D
@export var max_hp := 10
@export var current_hp := max_hp
@export var actions: Array[CombatAction]