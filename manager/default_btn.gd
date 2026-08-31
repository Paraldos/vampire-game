extends Button
class_name DefaultBtn

@export var grab_focus_on_ready := false

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

func _ready() -> void:
	button_disabled = disabled
	if grab_focus_on_ready and !button_disabled:
		await get_tree().process_frame
		grab_focus()
