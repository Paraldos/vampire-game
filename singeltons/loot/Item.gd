extends Node
class_name Item

@export var display_name : String
@export var slot : GlobalEnums.ItemSlots
@export var type : GlobalEnums.ItemType
@export var attack_animation : GlobalEnums.AttackAnimation
@export var attack_range : GlobalEnums.AttackRange
@export var base_stats : Dictionary = { "dmg": 0, "armor": 0 }
@export var texture : Texture2D
