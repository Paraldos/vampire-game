extends CanvasLayer

func _on_new_btn_pressed() -> void:
	Utils.game_data = GameData.new()
	LevelManager.respawn()
