extends Node
class_name StateMachine

@export var initial_state := "Idle"

var character : CharacterTemplate
var current_state: State
var states: Dictionary = {}

func setup(character_ref : CharacterTemplate) -> void:
	character = character_ref
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.setup(character, self)
	change_state(initial_state)

func change_state(new_state_name: StringName) -> void:
	var new_state: State = states.get(new_state_name, null)
	if new_state == null:
		push_warning("State not found: %s" % String(new_state_name))
		return
	if current_state != null:
		current_state.exit()
	current_state = new_state
	current_state.enter()

func physics_tick(delta: float) -> void:
	if current_state != null:
		current_state.physics_tick(delta)
