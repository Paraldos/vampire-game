extends DefaultBtn

@export var action : CombatAction
var had_focus = false

func _ready() -> void:
	GlobalSignals.action_selected.connect(_on_action_selected)
	GlobalSignals.action_cancelled.connect(_on_action_cancelled)
	update()

func _on_pressed() -> void:
	action.select()
	had_focus = true

func update() -> void:
	disabled = action == null
	if disabled: return
	icon = action.img

func _on_action_selected(_selected_action: CombatAction):
	disabled = true

func _on_action_cancelled() -> void:
	update()
	if had_focus:
		grab_focus()
	had_focus = false
