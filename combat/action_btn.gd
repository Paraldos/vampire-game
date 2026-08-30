extends DefaultBtn

@export var action : CombatAction

func _ready() -> void:
	update()

func update() -> void:
	disabled = action == null
	if disabled: return
	icon = action.img

func _on_pressed() -> void:
	print('pressed')
