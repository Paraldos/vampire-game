extends Node
# GameData

var save_game: SaveGame
var game_state := Enums.GAME_STATES.EXPLORE

var level_manager : LevelManager:
	get:
		return save_game.level_manager

func _ready() -> void:
	SaveManager.new_game()
