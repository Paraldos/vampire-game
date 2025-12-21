extends CanvasLayer

@onready var character: PanelContainer = %Character
@onready var inventory: PanelContainer = %Inventory

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed('ui_character'):
		character.visible = !character.visible
	if Input.is_action_just_pressed('ui_inventory'):
		inventory.visible = !inventory.visible
