extends CanvasLayer
# CombatWindow

func _ready() -> void:
	Utils.game_data.game_state = Enums.GAME_STATES.COMBAT
