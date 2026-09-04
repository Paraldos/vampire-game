extends CanvasLayer

@onready var conversation_output: RichTextLabel = %ConversationOutput
@onready var texture_player: TextureRect = %TexturePlayer
@onready var texture_npc: TextureRect = %TextureNPC

func _ready() -> void:
	Utils.game_data.game_state = Enums.GAME_STATES.CONVERSATION
	GlobalSignals.update_conversation.connect(_update)
	_update()

func _update():
	_update_conversation()

func _update_conversation():
	texture_npc.texture = ConversationManager.current_conversation.img
	conversation_output.text = "%s: %s" % [
		ConversationManager.get_character_name(),
		ConversationManager.get_current_output()]
