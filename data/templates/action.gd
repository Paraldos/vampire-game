extends Resource
class_name Action

@export var title := ""
@export var img :Texture2D

func can_use() -> bool:
	return true

func use() -> void:
	print("use")
