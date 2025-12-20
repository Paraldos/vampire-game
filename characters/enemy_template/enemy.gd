extends CharacterTemplate

@onready var state_machine: EnemyStateMachine = %EnemyStateMachine
var spawn_cell: Vector2i
var enemy_cell : Vector2i :
	get: return Utils.pos_to_cell(global_position)

func _ready() -> void:
	super()
	spawn_cell = Utils.pos_to_cell(global_position)
	Utils.map.astar_grid.set_point_solid(spawn_cell, true)
	state_machine.setup(self)

func _physics_process(delta: float) -> void:
	super(delta)
	state_machine.physics_tick(delta)

func _on_area_2d_mouse_entered() -> void:
	return
	# var mat := sprite_idle.material as ShaderMaterial
	# mat.set_shader_parameter("outline_color", Color("ffffffff"))

func _on_area_2d_mouse_exited() -> void:
	return
	# var mat := sprite_idle.material as ShaderMaterial
	# mat.set_shader_parameter("outline_color", Color("ffffff00"))

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		SignalController.left_click_enemy.emit(self)
