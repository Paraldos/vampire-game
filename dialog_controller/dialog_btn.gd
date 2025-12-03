extends Button

var option

func _ready() -> void:
	if not option:
		text = "End"
	elif option.btn_text:
		text = option.btn_text
	else:
		text = "Next"

func _on_pressed() -> void:
	if not option:
		SignalController.end_dialog.emit()
	else:
		SignalController.change_dialog.emit(option)
