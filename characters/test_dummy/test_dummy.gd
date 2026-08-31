extends Node2D

@export var test_combat: Enemy

func _on_bumper_bumped() -> void:
	GameData.combat_manager.start_combat(test_combat)
