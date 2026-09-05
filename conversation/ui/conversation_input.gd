extends Control

@onready var player_input: LineEdit = %PlayerInput
@onready var input_suggestion: Label = %InputSuggestion

func _ready() -> void:
	player_input.keep_editing_on_text_submit = true
	player_input.focus_mode = Control.FOCUS_ALL
	player_input.grab_focus()
	player_input.gui_input.connect(_on_player_input_gui_input)
	player_input.text = ""
	input_suggestion.text = ""

func _on_player_input_gui_input(event: InputEvent) -> void:
	if event is not InputEventKey: return
	if not event.pressed: return
	if event.echo: return
	if event.keycode != KEY_TAB: return
	_on_tab()

func _on_player_input_text_changed(_new_text: String) -> void:
	_fill_suggestion()

func _on_player_input_text_submitted(input: String) -> void:
	if input.is_empty(): return
	player_input.clear()
	ConversationManager.submit_keyword(input)

# ========================================== controlls
func _on_tab() -> void:
	var match = _get_autocomplete()
	if match != "":
		player_input.text = match
		player_input.caret_column = player_input.text.length()
	player_input.accept_event()
	_fill_suggestion()

func _get_autocomplete() -> String:
	var known_keys: Array[String] = ConversationManager.get_known_keys()
	var norm_input: String = Utils.normalize_txt(player_input.text)
	var matches: Array[String] = []
	for key in known_keys:
		var norm_key = Utils.normalize_txt(key)
		if norm_key.begins_with(norm_input):
			matches.append(key)
	if matches.size() == 1:
		return matches[0]
	else:
		return ""

func _fill_suggestion():
	input_suggestion.text = player_input.text
	var autocomplete = _get_autocomplete()
	if autocomplete != "":
		var slice = autocomplete.erase(0, player_input.text.length())
		input_suggestion.text += slice
