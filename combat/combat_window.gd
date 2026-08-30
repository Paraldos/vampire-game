extends CanvasLayer
# CombatWindow

const CHARACTER_DISPLAY = preload("uid://5ahfy3gthgwu")
@onready var enemy_slots := [
	%EnemySlot0,
	%EnemySlot1,
	%EnemySlot2,
	%EnemySlot3,
]
@onready var hero_slots := [
	%HeroSlot0,
	%HeroSlot1,
	%HeroSlot2,
	%HeroSlot3,
]

func _ready() -> void:
	GameData.game_state = Enums.GAME_STATES.COMBAT
	_create_displays(CombatManager.get_enemy_formation(), false)
	_create_displays(PlayerManager.hero_formation, true)

func _create_displays(formation : Array, is_hero_display := false):
	var slots := hero_slots if is_hero_display else enemy_slots
	for i in Combat.COMBAT_SIZE:
		var character := formation[i] as Character
		if character == null:
			continue
		var display := CHARACTER_DISPLAY.instantiate()
		display.slot = i
		display.character = character
		display.is_hero = is_hero_display
		slots[i].add_child(display)
