extends Node
class_name State

var character : CharacterTemplate
var state_machine: StateMachine
var rng := RandomNumberGenerator.new()
var occupied_cell:
	get:
		return character.occupied_cell
var global_position:
	get:
		return character.global_position
var is_active:
	get:
		return state_machine.current_state == self

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
