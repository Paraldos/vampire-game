extends Node
class_name State

var actor: Node
var state_machine: StateMachine

signal transition_requested(state_name: StringName)

func start():
	pass

func stop():
	pass

func physics_process(_delta: float) -> void:
	pass

func transition_to(state_name: StringName) -> void:
	transition_requested.emit(state_name)
