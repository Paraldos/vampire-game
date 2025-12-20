extends Node
class_name EnemyState

var enemy: Enemy
var state_machine: EnemyStateMachine

func setup(enemy_ref: Enemy, sm_ref: EnemyStateMachine) -> void:
	enemy = enemy_ref
	state_machine = sm_ref

func enter() -> void:
	pass

func exit() -> void:
	pass

func physics_tick(_delta: float) -> void:
	pass
