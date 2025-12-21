extends CanvasLayer

func _on_button_pressed() -> void:
	PlayerProfile.gold = 0
	PlayerProfile.xp = 0
	PlayerProfile.lvl = 1
	_reset_inventory()

func _reset_inventory():
	var sword = ItemInstance.new()
	sword.item_id = "sword"
	sword.quality = 0
	var armor = ItemInstance.new()
	armor.item_id = "armor"
	armor.quality = 0
	PlayerProfile.inventory = [sword, armor]
