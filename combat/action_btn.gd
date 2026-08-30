extends DefaultBtn

@export var action : CombatAction:
	set(value):
		action = value
		update()
var had_focus = false

func _ready() -> void:
	GlobalSignals.action_selected.connect(_on_action_selected)
	update()

func _on_pressed() -> void:
	action.select()
	had_focus = true

func update() -> void:
	button_disabled = action == null
	if button_disabled: return
	icon = action.img

func _on_action_selected(_selected_action: CombatAction):
	pass
