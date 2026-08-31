extends Node
# GameData

var save_game: SaveGame
var game_state := Enums.GAME_STATES.START_MENU

var combat_manager: CombatManager:
	get:
		return save_game.combat_manager
var player_manager: PlayerManager:
	get:
		return save_game.player_manager
var level_manager : LevelManager:
	get:
		return save_game.level_manager

func _ready() -> void:
	SaveManager.new_game()
