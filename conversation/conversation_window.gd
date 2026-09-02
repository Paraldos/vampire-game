extends CanvasLayer

@onready var suggestions: Label = %Suggestions
@onready var conversation_output: Label = %ConversationOutput
@onready var player_input: LineEdit = %PlayerInput

func _ready() -> void:
	GameData.game_state = Enums.GAME_STATES.CONVERSATION
	player_input.keep_editing_on_text_submit = true
	player_input.grab_focus()
	_update_conversation()
	_update_suggestions()

func _on_player_input_text_submitted(input: String) -> void:
	var normalized_input := _normalize(input)
	if normalized_input.is_empty(): return

	ConversationManager.submit_keyword(normalized_input)

	_update_conversation()
	_update_suggestions()

# ========================================== Helper
func _update_conversation():
	player_input.clear()
	conversation_output.text = "%s: %s" % [
		ConversationManager.get_character_name(),
		ConversationManager.get_current_output()]

func _update_suggestions() -> void:
	var conversation := ConversationManager.current_conversation
	suggestions.text = "Suggestions: %s" % [
		", ".join(PackedStringArray(conversation.suggestions))]

func _normalize(text: String) -> String:
	return text.strip_edges().to_lower()
