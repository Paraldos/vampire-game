extends Node
class_name StateMachine

@export var actor: Node
@export var initial_state: State

var current_state: State
var states: Dictionary[StringName, State]

func _ready() -> void:
	if actor == null:
		actor = get_parent()
	_find_states()
	if initial_state:
		_change_state(initial_state.name)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.run(delta)

func _find_states() -> void:
	for child in get_children():
		if child is not State: continue
		var state := child as State
		states[state.name] = state
		state.actor = actor
		state.state_machine = self

func _change_state(state_name: StringName) -> void:
	if not states.has(state_name):
		push_warning("State '%s' does not exist." % state_name)
		return
	var next_state: State = states[state_name]
	if next_state == current_state:
		return
	if current_state:
		current_state.stop()
	current_state = next_state
	current_state.start()