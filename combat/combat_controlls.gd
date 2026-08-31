extends PanelContainer

@onready var actions_container: GridContainer = %ActionsContainer
const ACTION_BTN = preload("uid://bgaxwo36tpkjn")

func _ready() -> void:
	GlobalSignals.enable_action_btns.connect(grab_first_valid_btn)
	Utils.clear_container(actions_container)
	for action in PlayerManager.get_actions():
		_add_action_btn(action)
	_add_action_btn(load("res://data/actions/pass.tres"))
	grab_first_valid_btn()

func _add_action_btn(action : Action):
	var btn := ACTION_BTN.instantiate()
	btn.action = action
	actions_container.add_child(btn)

func grab_first_valid_btn():
	await get_tree().process_frame
	for btn in actions_container.get_children():
		if btn is DefaultBtn and !btn.disabled:
			btn.grab_focus()
			return
