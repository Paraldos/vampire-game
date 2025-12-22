extends Resource
class_name ItemInstance

var item_id: StringName
var texture_frame: int
var texture_size : Vector2:
	get:
		return LootSystem.get_item_texture_size(item_id)
var display_name : String:
	get:
		return LootSystem.get_item(item_id).display_name
var slot : GlobalEnums.ItemSlots:
	get:
		return LootSystem.get_item(item_id).slot
var type : GlobalEnums.ItemType:
	get:
		return LootSystem.get_item(item_id).type
var attack_animation : GlobalEnums.AttackAnimation:
	get:
		return LootSystem.get_item(item_id).attack_animation
var texture : Texture2D:
	get:
		return LootSystem.get_item(item_id).texture

var quality: int = GlobalEnums.ItemQuality.COMMON

var affixes: Array[Dictionary] = []