extends CharacterBody2D

@export var combat: Enemy
@export var conversation: Conversation

func _on_bumper_bumped() -> void:
	if combat:
		CombatManager.start_combat(combat)
	elif conversation:
		ConversationManager.start_conversation(conversation)
	else:
		pass
