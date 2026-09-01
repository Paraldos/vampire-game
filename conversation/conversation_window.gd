extends CanvasLayer

@onready var suggestions: Label = %Suggestions
@onready var text: Label = %Text
@onready var player_input: LineEdit = %PlayerInput

func _ready() -> void:
	GameData.game_state = Enums.GAME_STATES.CONVERSATION
	player_input.keep_editing_on_text_submit = true
	player_input.grab_focus()
	_update_suggestions()

func _on_player_input_text_submitted(new_text: String) -> void:
	var normalized_input := _normalize(new_text)
	if normalized_input.is_empty():
		return
	var response := ConversationManager.submit_keyword(normalized_input)
	text.text = response
	player_input.clear()
	_update_suggestions()

# ========================================== Helper
func _update_suggestions() -> void:
	var conversation := ConversationManager.current_conversation
	suggestions.text = "Suggestions: %s" % [
		", ".join(PackedStringArray(conversation.suggestions))
	]

func _normalize(text: String) -> String:
	return text.strip_edges().to_lower()
