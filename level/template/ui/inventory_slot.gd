extends TextureRect
class_name InventorySlot

@onready var item_container: Node2D = %ItemContainer

@export var slot_type = GlobalEnums.ItemSlots.BACKPACK
var inventory_item_bp = preload("res://level/template/ui/inventory_item.tscn")
var index
var viable = false

func _ready() -> void:
	index = slot_type
	if slot_type == GlobalEnums.ItemSlots.BACKPACK: index += get_index()
	Signals.update_inventory.connect(_on_update_inventory)
	_on_update_inventory()

func _on_update_inventory():
	end_item_hover()
	for child in item_container.get_children():
		child.queue_free()
	if PlayerProfile.inventory[index] != null:
		var inventory_item = inventory_item_bp.instantiate()
		inventory_item.index = index
		item_container.add_child(inventory_item)

func end_item_hover():
	_set_to_non_viable()
	self_modulate = Color('819796')

func start_item_hover(item : ItemInstance):
	if item.slot == slot_type:
		_set_to_viable()
	elif slot_type == GlobalEnums.ItemSlots.BACKPACK:
		_set_to_viable()
	else:
		_set_to_non_viable()

func _set_to_viable():
	self_modulate = Color('75a743')
	viable = true
	z_index = 5

func _set_to_non_viable():
	self_modulate = Color('a53030')
	viable = false
	z_index = 0
