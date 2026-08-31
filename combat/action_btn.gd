extends DefaultBtn

@export var action : Action

func _ready() -> void:
	if action == null:
		queue_free()
		return
	icon = action.img

func _on_pressed() -> void:
	print('pressed')
