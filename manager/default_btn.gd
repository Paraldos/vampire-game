extends Button
class_name DefaultBtn

var button_disabled: bool:
	get:
		return disabled
	set(value):
		disabled = value
		focus_mode = (
			Control.FOCUS_NONE
			if value
			else Control.FOCUS_ALL
		)
		if value and has_focus():
			release_focus()

func _init() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	focus_mode = Control.FOCUS_ALL
	button_disabled = disabled
