extends Node

var dialog_ui_bp = preload("res://dialog_controller/dialog_ui.tscn")

func start_dialog(dialog_id := ""):
	var selected_dialog = get_node(dialog_id)
	if not selected_dialog: return
	var dialog_ui = dialog_ui_bp.instantiate()
	dialog_ui.current_dialog = selected_dialog
	get_tree().current_scene.add_child(dialog_ui)

func get_dialog(dialog_id := ""):
	return get_node(dialog_id)
