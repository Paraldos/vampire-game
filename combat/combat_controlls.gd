extends MarginContainer

func _ready() -> void:
	_on_activate_character(CombatManager.get_active_character())
	GlobalSignals.activate_character.connect(_on_activate_character)

func _on_activate_character(activted_character : Character):
	if activted_character is Enemy:
		pass
	if activted_character is Hero:
		for action in activted_character.actions:
			print(action)
