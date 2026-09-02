extends CanvasLayer

@onready var suggested_keys: RichTextLabel = %SuggestedKeys
@onready var conversation_output: RichTextLabel = %ConversationOutput
@onready var player_input: LineEdit = %PlayerInput

func _ready() -> void:
	GameData.game_state = Enums.GAME_STATES.CONVERSATION
	player_input.keep_editing_on_text_submit = true
	player_input.grab_focus()
	_update_conversation()
	_update_suggestions()

func _on_player_input_text_submitted(input: String) -> void:
	if input.is_empty(): return
	ConversationManager.submit_keyword(input)
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
	suggested_keys.text = ""

	if !conversation.suggested_keys.is_empty():
		suggested_keys.text = "Suggestions: "
		suggested_keys.text += ", ".join(
			PackedStringArray(conversation.suggested_keys))
		suggested_keys.text += "\n"

	if !conversation.used_keys.is_empty():
		suggested_keys.text += "Discussed: "
		suggested_keys.text += "[color=#577277]"
		suggested_keys.text += ", ".join(
			PackedStringArray(conversation.used_keys))
		suggested_keys.text += "[/color]"

func _normalize(text: String) -> String:
	return text.strip_edges().to_lower()
