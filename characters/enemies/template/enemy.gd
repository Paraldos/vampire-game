extends Node2D
class_name Enemy

@onready var sprite_idle: AnimatedSprite2D = $SpriteIdle

func _ready() -> void:
	Utils.map.astar_grid.set_point_solid(Utils.map.local_to_map(global_position), true)

func _on_area_2d_mouse_entered() -> void:
	var mat := sprite_idle.material as ShaderMaterial
	mat.set_shader_parameter("outline_color", Color("ffffffff"))

func _on_area_2d_mouse_exited() -> void:
	var mat := sprite_idle.material as ShaderMaterial
	mat.set_shader_parameter("outline_color", Color("ffffff00"))

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		SignalController.left_click_enemy.emit(self)
