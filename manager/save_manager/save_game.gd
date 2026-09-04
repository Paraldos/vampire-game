extends Resource
class_name SaveGame

@export var level_manager := LevelManager.new()

# player
@export_storage var max_hp := 20
@export_storage var current_hp := max_hp
@export_storage var max_armor := 20
@export_storage var current_armor := max_armor
@export_storage var attack := 10
@export_storage var actions :Array[Action] = [
	load("res://data/actions/slash.tres"),
	load("res://data/actions/defend.tres")
]

# conversation
@export_storage var current_conversation: Conversation
@export_storage var saved_conversations: Array[Conversation]

# combat
@export_storage var enemy: Enemy
@export_storage var player_turn := true
