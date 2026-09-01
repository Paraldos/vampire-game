extends Node2D

@export var test_combat: Enemy
@export var test_conversation: Conversation

func _on_bumper_bumped() -> void:
	if test_combat:
		GameData.combat_manager.start_combat(test_combat)
	elif test_conversation:
		ConversationManager.start_conversation(test_conversation)
