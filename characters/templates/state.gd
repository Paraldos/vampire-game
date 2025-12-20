extends Node
class_name State

var character : CharacterTemplate
var state_machine: StateMachine
var rng := RandomNumberGenerator.new()

func setup(character_ref : CharacterTemplate, sm_ref: StateMachine) -> void:
	rng.randomize()
	character = character_ref
	state_machine = sm_ref

func enter() -> void:
	pass

func exit() -> void:
	pass

func physics_tick(_delta: float) -> void:
	pass
