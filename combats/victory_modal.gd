extends Modal

func _on_default_btn_pressed() -> void:
	close()
	GameData.combat_manager.end_combat()
