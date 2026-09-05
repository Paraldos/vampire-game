extends CanvasLayer

@onready var conversation_output: RichTextLabel = %ConversationOutput

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
