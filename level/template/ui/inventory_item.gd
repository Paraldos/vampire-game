extends Control

@onready var mouse_area: Area2D = %MouseArea
@onready var collision_area: Area2D = %CollisionArea
var mouse_hover = false
var move = false
var item : ItemInstance
var index : int
var is_ready = false
var start_position : Vector2

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed('ui_left_click') and mouse_hover:
		move = true
		start_position = global_position
	if Input.is_action_just_released('ui_left_click') and move:
		_end_movement()
	if move:
		_move()

func _end_movement():
	move = false
	if collision_area.has_overlapping_areas():
		var overlap = collision_area.get_overlapping_areas()[0]
		if overlap.get_parent() is InventorySlot:
			var target_index = overlap.get_parent().index
			PlayerProfile.swap_items(index, target_index)
			return
	global_position = start_position

func _move():
	global_position = get_global_mouse_position() - Vector2(10,10)

func _on_mouse_area_mouse_entered() -> void:
	mouse_hover = true

func _on_mouse_area_mouse_exited() -> void:
	mouse_hover = false
