extends CharacterBody2D

@export var dialog_id := ""

func _on_action_action() -> void:
	if dialog_id:
		DialogController.start_dialog(dialog_id)
