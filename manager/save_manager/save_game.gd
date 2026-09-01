extends Resource
class_name SaveGame

@export var combat_manager := CombatManager.new()
@export var player_manager := PlayerManager.new()
@export var level_manager := LevelManager.new()
@export var conversation_manager := ConversationManager.new()

@export_storage var current_conversation : Conversation
