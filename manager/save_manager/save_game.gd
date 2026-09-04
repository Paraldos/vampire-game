extends Resource
class_name SaveGame

@export var player_manager := PlayerManager.new()
@export var level_manager := LevelManager.new()

# conversation
@export_storage var current_conversation: Conversation
@export_storage var saved_conversations: Array[Conversation]

# combat
@export_storage var enemy: Enemy
@export_storage var player_turn := true
