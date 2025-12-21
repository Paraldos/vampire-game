extends TextureRect
class_name InventorySlot

var inventory_item_bp = preload("res://level/template/ui/inventory_item.tscn")
@onready var item_container: Node2D = %ItemContainer

func _ready() -> void:
	_on_update_inventory()
	Signals.update_inventory.connect(_on_update_inventory)

func _on_update_inventory():
	for child in item_container.get_children():
		child.queue_free()
	if PlayerProfile.backpack[get_index()]:
		var inventory_item = inventory_item_bp.instantiate()
		inventory_item.index = get_index()
		item_container.add_child(inventory_item)
