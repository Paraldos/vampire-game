extends Control

@onready var sprite: Sprite2D = %Sprite
@onready var mouse_area: Area2D = %MouseArea
@onready var collision_area: Area2D = %CollisionArea
var mouse_hover = false
var move = false
var item : ItemInstance
var index : int
var is_ready = false
var start_position : Vector2
var mouse_offset = Vector2(10,10)

func _ready() -> void:
	item = PlayerProfile.inventory[index]
	_init_sprite()

func _init_sprite():
	sprite.texture = item.texture
	sprite.hframes = round(item.texture_size.x)
	sprite.vframes = round(item.texture_size.y)
	sprite.frame = item.texture_frame
	sprite.modulate = LootSystem.get_quality_color(item.quality)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed('ui_left_click') and mouse_hover:
		_start_movement()
	if Input.is_action_just_released('ui_left_click') and move:
		_end_movement()
		_change_slot()
	if move:
		global_position = get_global_mouse_position() - mouse_offset

func _start_movement():
	z_index = 15
	move = true
	start_position = global_position

func _end_movement():
	z_index = 5
	move = false
	global_position = start_position

func _change_slot():
	if not collision_area.has_overlapping_areas(): return
	var overlap = collision_area.get_overlapping_areas()[0]
	var overlapping_slot = overlap.get_parent()
	if not overlapping_slot is InventorySlot: return
	if not overlapping_slot.viable: return
	var target_index = overlapping_slot.index
	PlayerProfile.swap_items(index, target_index)
	return

func _on_mouse_area_mouse_entered() -> void:
	mouse_hover = true

func _on_mouse_area_mouse_exited() -> void:
	mouse_hover = false

func _on_collision_area_area_entered(area: Area2D) -> void:
	if not move: return
	var slot : InventorySlot = area.get_parent()
	slot.start_item_hover(item)

func _on_collision_area_area_exited(area: Area2D) -> void:
	var slot :InventorySlot = area.get_parent()
	slot.end_item_hover()
