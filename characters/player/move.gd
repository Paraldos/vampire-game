extends State

var target_cell

func _ready() -> void:
	Signals.left_clicked_floor.connect(_on_left_clicked_floor)

func exit():
	character.stop_moving()

func physics_tick(delta: float) -> void:
	if not character.animating:
		if not character._is_next_step_valid():
			character.path = Utils.get_astar_path(occupied_cell, target_cell)
		elif character.path.size() > 0:
			character.start_moving()
		else:
			state_machine.change_state('Idle')
	elif character.animating:
		character.move(delta)
	else:
		state_machine.change_state('Idle')

func _on_left_clicked_floor(target : Vector2i) -> void:
	if not Utils.mouse_on_map: return
	if Input.is_action_pressed('ui_shift'): return
	if character.animating: return
	target_cell = target
	character.attack_target = null
	character.path = Utils.get_astar_path(occupied_cell, target_cell)
	character.stop_moving()
	state_machine.change_state('Move')
