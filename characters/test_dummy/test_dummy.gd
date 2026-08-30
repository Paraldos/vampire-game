extends Node2D

func _on_bumper_bumped() -> void:
	SceneManager.change_scene(SceneManager.COMBAT)
