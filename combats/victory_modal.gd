extends Modal

func _on_default_btn_pressed() -> void:
	close()
	CombatManager.end_combat()
