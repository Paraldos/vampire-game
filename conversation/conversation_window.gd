extends CanvasLayer

@onready var suggested_keys: RichTextLabel = %SuggestedKeys
@onready var conversation_output: RichTextLabel = %ConversationOutput
@onready var player_input: LineEdit = %PlayerInput
@onready var complet_suggestion: Label = %CompletSuggestion

func _ready() -> void:
	GameData.game_state = Enums.GAME_STATES.CONVERSATION
	player_input.keep_editing_on_text_submit = true
	player_input.focus_mode = Control.FOCUS_ALL
	player_input.grab_focus()
	player_input.gui_input.connect(_on_player_input_gui_input)
	_update_conversation()
	_update_suggestions()

func _on_player_input_gui_input(event: InputEvent) -> void:
	if (event is InputEventKey
		and event.pressed
		and not event.echo
		and event.keycode == KEY_TAB
	):
		_on_tab()
		player_input.accept_event()

func _on_player_input_text_changed(_new_text: String) -> void:
	complet_suggestion.text = autocomplete()

func _on_player_input_text_submitted(input: String) -> void:
	if input.is_empty(): return
	ConversationManager.submit_keyword(input)
	_update_conversation()
	_update_suggestions()

# ========================================== Autocomplete Logic
func _on_tab() -> void:
	var match = autocomplete()
	if match != "":
		player_input.text = match
		player_input.caret_column = player_input.text.length()

func autocomplete() -> String:
	var conversation := ConversationManager.current_conversation

	var candidates: Array[String] = []
	candidates.append_array(conversation.suggested_keys)
	candidates.append_array(conversation.used_keys)

	var normalized_suggestion: String = Utils.normalize_txt(player_input.text)
	var matches: Array[String] = []
	for key in candidates:
		var normalized_key = Utils.normalize_txt(key)
		if normalized_key.contains(normalized_suggestion):
			matches.append(key)
	if matches.size() == 1:
		return matches[0]
	else:
		return ""

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
