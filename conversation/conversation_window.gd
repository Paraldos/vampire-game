extends CanvasLayer

@onready var text: Label = %Text
@onready var player_input: LineEdit = %PlayerInput

var conversation

func _ready() -> void:
	player_input.grab_focus()

func _on_player_input_text_submitted(new_text: String) -> void:
	pass # Replace with function body.
