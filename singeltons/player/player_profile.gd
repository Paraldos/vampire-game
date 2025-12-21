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
var BACKPACK_SIZE := 16
var backpack: Array = []

func _reset_backpack():
	backpack.clear()
	backpack.resize(BACKPACK_SIZE)
	for i in BACKPACK_SIZE:
		backpack[i] = null

func add_item(item : ItemInstance):
	for i in backpack.size():
		var slot = backpack[i]
		if not slot == null: continue
		PlayerProfile.backpack[i] = item
		return
