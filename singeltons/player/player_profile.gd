extends Node

var stats
var gold := 0
var xp := 0
var lvl := 1
var hp_max := 50
var hp_current := 50

var mainhand : ItemInstance
var offhand : ItemInstance
var head : ItemInstance
var torso : ItemInstance
var trinket : ItemInstance
var BACKPACK_SIZE := 18
var inventory: Array = []

func reset_inventory():
	inventory.clear()
	inventory.resize(GlobalEnums.ItemSlots.BACKPACK + BACKPACK_SIZE)

func add_item(item : ItemInstance) -> void:
	for i in range(GlobalEnums.ItemSlots.BACKPACK, inventory.size()):
		var slot = inventory[i]
		if not slot == null: continue
		PlayerProfile.inventory[i] = item
		Signals.update_inventory.emit()
		return

func swap_items(from: int, to: int) -> void:
	var tmp = inventory[from]
	inventory[from] = inventory[to]
	inventory[to] = tmp
	Signals.update_inventory.emit()
