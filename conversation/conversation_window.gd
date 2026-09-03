extends CanvasLayer

@onready var conversation_output: RichTextLabel = %ConversationOutput

func _ready() -> void:
	GameData.game_state = Enums.GAME_STATES.CONVERSATION
	GlobalSignals.update_conversation.connect(_update)
	_update()

func _update():
	_update_conversation()

func _update_conversation():
	conversation_output.text = "%s: %s" % [
		ConversationManager.get_character_name(),
		ConversationManager.get_current_output()]
