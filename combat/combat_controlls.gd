extends MarginContainer

@onready var actions_container: HBoxContainer = %ActionsContainer
@onready var default_container: HBoxContainer = %DefaultContainer
const ACTION_BTN = preload("uid://bgaxwo36tpkjn")

func _ready() -> void:
	_on_activate_character(CombatManager.get_active_character())
	GlobalSignals.activate_character.connect(_on_activate_character)

func _on_activate_character(activated_character: Character) -> void:
	for i in actions_container.get_child_count():
		var btn :DefaultBtn = actions_container.get_child(i)
		if i < activated_character.actions.size():
			btn.action = activated_character.actions[i]
			btn.update()
		else:
			btn.action = null
	actions_container.get_child(0).grab_focus()
