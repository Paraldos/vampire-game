extends Resource
class_name GameData

# general
var game_state = Enums.GAME_STATES.START_MENU

# player
@export_storage var max_hp := 20
@export_storage var current_hp := 0
@export_storage var max_armor := 20
@export_storage var current_armor := max_armor
@export_storage var attack := 10
@export_storage var actions :Array[Action] = [
	load("res://data/actions/slash.tres"),
	load("res://data/actions/defend.tres")
]

# level
@export_storage var current_level : PackedScene = load("uid://c4hx48uxrnfdn")
@export_storage var respawn_level : PackedScene = load("uid://c4hx48uxrnfdn")

# conversation
@export_storage var current_conversation: Conversation
@export_storage var saved_conversations: Array[Conversation]

# combat
@export_storage var enemy: Enemy
@export_storage var player_turn := true
