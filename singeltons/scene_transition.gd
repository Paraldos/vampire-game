extends Area2D

@export var target_map : String

func _on_body_entered(_body: Node2D) -> void:
	SceneLoader.change_scene(target_map)
