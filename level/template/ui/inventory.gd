extends PanelContainer

@onready var backpack: GridContainer = %Backpack
var inventory_item_bp = preload("res://level/template/ui/inventory_item.tscn")

func _ready() -> void:
	for i in backpack.get_children().size():
		var slot = backpack.get_child(i)
		slot.index = i

func update():
	for index in PlayerProfile.backpack.size():
		var item = PlayerProfile.backpack[index]
		print(item)
		if item == null: continue
		var inventory_item = inventory_item_bp.instantiate()
		var slot = backpack.get_child(index)
		slot.add_child(inventory_item)