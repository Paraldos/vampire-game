extends Node
class_name EnemyState

var character : CharacterTemplate
var state_machine: EnemyStateMachine

func setup(character_ref : CharacterTemplate, sm_ref: EnemyStateMachine) -> void:
	character = character_ref
	state_machine = sm_ref

func enter() -> void:
	pass

func exit() -> void:
	pass

func physics_tick(_delta: float) -> void:
	pass
