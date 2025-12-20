extends Node
class_name EnemyStateMachine

@export var initial_state := "Idle"

var enemy: Enemy
var current_state: EnemyState
var states: Dictionary = {} # StringName -> EnemyState

func setup(enemy_ref: Enemy) -> void:
	enemy = enemy_ref
	for child in get_children():
		if child is EnemyState:
			states[child.name] = child
			child.setup(enemy, self)
	change_state(initial_state)

func change_state(state_name: StringName) -> void:
	var new_state: EnemyState = states.get(state_name, null)
	if new_state == null:
		push_warning("State not found: %s" % String(state_name))
		return
	if current_state != null:
		current_state.exit()
	current_state = new_state
	current_state.enter()

func physics_tick(delta: float) -> void:
	if current_state != null:
		current_state.physics_tick(delta)
