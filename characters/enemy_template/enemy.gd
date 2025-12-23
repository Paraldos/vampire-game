extends CharacterTemplate

var spawn_cell: Vector2i
var enemy_cell : Vector2i :
	get: return Utils.pos_to_cell(global_position)
var hover := false

func _ready() -> void:
	super()
	spawn_cell = Utils.pos_to_cell(global_position)
	Utils.map.astar_grid.set_point_solid(spawn_cell, true)
	state_machine.setup(self)

func _physics_process(delta: float) -> void:
	super(delta)
	state_machine.physics_tick(delta)
	if hover and Input.is_action_pressed('ui_left_click'):
		Signals.left_click_enemy.emit(self)

func _on_mouse_area_mouse_entered() -> void:
	hover = true
	_change_color(color_hover)

func _on_mouse_area_mouse_exited() -> void:
	hover = false
	_change_color(color_default)

func _change_color(new_color : Color):
	var mat := character_sprite.material as ShaderMaterial
	mat.set_shader_parameter("new_color", new_color)
