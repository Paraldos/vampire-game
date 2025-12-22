extends CanvasLayer

func _on_new_game_btn_pressed() -> void:
	PlayerProfile.gold = 0
	PlayerProfile.xp = 0
	PlayerProfile.lvl = 1
	_reset_inventory()
	SceneManager.change_scene("res://level/graveyard.tscn")

func _reset_inventory():
	PlayerProfile.reset_inventory()

	var sword = ItemInstance.new()
	sword.item_id = "sword"
	PlayerProfile.add_item(sword)

	var bow = ItemInstance.new()
	bow.item_id = "bow"
	PlayerProfile.add_item(bow)

	var armor = ItemInstance.new()
	armor.item_id = "armor"
	PlayerProfile.add_item(armor)
