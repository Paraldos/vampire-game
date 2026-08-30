extends CanvasLayer
# CombatWindow

const CHARACTER_DISPLAY = preload("uid://5ahfy3gthgwu")
@onready var player_slots: Node2D = $PlayerSlots
@onready var enemy_slots: Node2D = $EnemySlots

func _ready() -> void:
	GameData.game_state = Enums.GAME_STATES.COMBAT
	_create_displays(CombatManager.get_enemy_formation(), false)
	_create_displays(PlayerManager.hero_formation, true)

func _create_displays(formation : Array, is_hero_display := false):
	print(formation)
	var slots := player_slots if is_hero_display else enemy_slots
	for i in 4:
		var character := formation[i] as Character
		if character == null:
			continue
		var display = CHARACTER_DISPLAY.instantiate()
		display.slot = i
		display.character = character
		display.is_hero = is_hero_display
		slots.get_child(i).add_child(display)
