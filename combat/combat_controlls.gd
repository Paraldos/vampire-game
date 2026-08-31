extends PanelContainer

@onready var actions_container: GridContainer = %ActionsContainer
const ACTION_BTN = preload("uid://bgaxwo36tpkjn")

func _ready() -> void:
	Utils.clear_container(actions_container)
	for action in PlayerManager.get_actions():
		_add_action_btn(action)
	_add_action_btn(load("res://data/actions/pass.tres"))
	actions_container.get_child(0).grab_focus()

func _add_action_btn(action : Action):
	var btn := ACTION_BTN.instantiate()
	btn.action = action
	actions_container.add_child(btn)
