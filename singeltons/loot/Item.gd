extends Node
class_name Item

@export var display_name: String
@export var slot : GlobalEnums.ItemSlots
@export var type : GlobalEnums.ItemType
@export var base_stats: Dictionary = { "dmg": 0, "armor": 0 }
