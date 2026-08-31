extends Resource
class_name LevelManager

@export_storage var level : PackedScene = load("uid://h6t750kmppjs")

func change_level(new_level : PackedScene) -> void:
	level = new_level
	SceneManager.change_scene(level)

func reload_level():
	SceneManager.change_scene(level)
