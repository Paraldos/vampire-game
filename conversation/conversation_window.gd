extends CanvasLayer

@onready var conversation_output: RichTextLabel = %ConversationOutput

const TEXT_SPEED := 100.0

func _ready() -> void:
	Utils.game_data.game_state = Enums.GAME_STATES.CONVERSATION
	GlobalSignals.update_conversation.connect(_update_conversation)
	_update_conversation()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		ConversationManager.end_conversation()

func _update_conversation():
	conversation_output.text = "%s: %s" % [
		ConversationManager.get_character_name(),
		ConversationManager.get_current_output()]
	_fade_in_text()

func _fade_in_text() -> void:
	var character_count := conversation_output.get_total_character_count()
	conversation_output.visible_characters = 0
	if character_count == 0:
		return
	var duration := character_count / TEXT_SPEED
	var t = create_tween()
	t.set_trans(Tween.TRANS_LINEAR)
	t.tween_property(conversation_output, "visible_characters", character_count,duration)
