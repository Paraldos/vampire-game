extends State

func _ready() -> void:
	SignalController.left_clicked_floor.connect(_on_left_clicked_floor)

func setup(character_ref : CharacterTemplate, sm_ref: StateMachine):
	super(character_ref, sm_ref)
	print('hi')

func physics_tick(delta: float) -> void:
	if not character.moving and character.path.size() > 0:
		character._start_moving(character.path.pop_front())
	if character.moving:
		character.move(delta)

func _on_left_clicked_floor(target_cell):
	if Input.is_action_pressed('shift'): return
	if character.attacking: return
	character.path = Utils.get_astar_path(character.occupied_cell, target_cell)
	if character.moving: character.path.pop_front()
	character.target_enemy = null
	state_machine.change_state('Move')
