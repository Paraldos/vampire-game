extends Node
# GameData

var save_game: SaveGame
var game_state := Enums.GAME_STATES.EXPLORE

func _ready() -> void:
	SaveManager.new_game()
