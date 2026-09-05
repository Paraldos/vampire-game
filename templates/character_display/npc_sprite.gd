extends DisplaySprite

func _ready() -> void:
	super()
	match Utils.game_data.game_state:
		Enums.GAME_STATES.COMBAT:
			texture = CombatManager.enemy.get_random_sprite()
		Enums.GAME_STATES.CONVERSATION:
			texture = ConversationManager.current_conversation.img
		_:
			texture = null
