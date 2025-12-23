extends CharacterTemplate

@onready var character_sprite: Sprite2D = %CharacterSprite
@onready var state_machine: StateMachine = %StateMachine
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
	var mat := character_sprite.material as ShaderMaterial
	mat.set_shader_parameter("new_color", Color("cf573c"))

func _on_mouse_area_mouse_exited() -> void:
	hover = false
	var mat := character_sprite.material as ShaderMaterial
	mat.set_shader_parameter("new_color", Color("090a14"))
