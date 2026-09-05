extends Resource
class_name GameData

# general
var game_state = Enums.GAME_STATES.START_MENU

# player
@export var max_hp := 20
@export var current_hp := max_hp
@export var max_armor := 20
@export var current_armor := max_armor
@export var attack := 10
@export var actions: Array[CombatAction] = [
	preload("uid://hjdega387jrv"),
	preload("uid://c2j3acita8x32")
]

# exploration
@export var current_level: PackedScene
@export var respawn_level: PackedScene = load("uid://c4hx48uxrnfdn")
@export var flags: Array[Flag]

# conversation
@export var current_conversation: Conversation
@export var saved_conversations: Array[Conversation]

# combat
@export var enemy: Enemy
@export var player_turn := true
