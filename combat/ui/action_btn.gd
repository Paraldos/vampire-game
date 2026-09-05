extends DefaultBtn

@export var action : CombatAction

func _ready() -> void:
	GlobalSignals.disable_action_btns.connect(_on_disable_action_btns)
	GlobalSignals.enable_action_btns.connect(_on_enable_action_btns)
	if action == null:
		queue_free()
		return
	icon = action.img
	disabled = !action.can_be_used(true)

func _on_pressed() -> void:
	action.use(true)

func _on_disable_action_btns():
	button_disabled = true

func _on_enable_action_btns():
	button_disabled = !action.can_be_used(true)

func _on_focus_entered() -> void:
	GlobalSignals.combat_action_focused.emit(action)
