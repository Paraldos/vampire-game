extends TextureRect
class_name InventorySlot

var inventory_item_bp = preload("res://level/template/ui/inventory_item.tscn")
var index
@onready var item_container: Node2D = %ItemContainer
@export var slot_type = GlobalEnums.ItemSlots.BACKPACK

func _ready() -> void:
	index = slot_type
	if slot_type == GlobalEnums.ItemSlots.BACKPACK: index += get_index()
	Signals.update_inventory.connect(_on_update_inventory)
	_on_update_inventory()

func _on_update_inventory():
	for child in item_container.get_children():
		child.queue_free()
	if PlayerProfile.inventory[index] != null:
		var inventory_item = inventory_item_bp.instantiate()
		inventory_item.index = index
		item_container.add_child(inventory_item)
