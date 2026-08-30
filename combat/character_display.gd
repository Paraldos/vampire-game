extends Node2D

@onready var main_sprite: Sprite2D = $MainSprite
@onready var active_indicator: Node2D = %ActiveIndicator
@onready var target_btn: Button = %TargetBtn

var slot := -1
var is_hero := false
var character: Character

func _ready() -> void:
	if slot == -1:
		queue_free()
		return
	GlobalSignals.activate_character.connect(_on_activate_character)
	GlobalSignals.action_selected.connect(_on_action_selected)
	if !is_hero:
		main_sprite.flip_h = true
	main_sprite.texture = character.combat_sprite
	active_indicator.visible = CombatManager.get_active_character() == character

func _on_action_selected(selected_action: CombatAction) -> void:
	var frontline := Combat.FRONTLINE_SLOTS.has(slot)
	target_btn.disabled = !selected_action.can_target(is_hero, frontline)

func _on_activate_character(activted_character : Character):
	active_indicator.visible = activted_character == character
