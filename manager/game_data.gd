extends Node
# GameData

var save_game: SaveGame
var game_state := Enums.GAME_STATES.START_MENU

func _ready() -> void:
	SaveManager.new_game()
