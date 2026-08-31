extends Node2D

@export var test_combat: Enemy

func _on_bumper_bumped() -> void:
	CombatManager.start_combat(test_combat)
