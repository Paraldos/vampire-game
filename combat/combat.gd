extends CanvasLayer

const CHARACTER_DISPLAY = preload("uid://5ahfy3gthgwu")
@onready var player_slots: Node2D = $PlayerSlots
@onready var enemy_slots: Node2D = $EnemySlots

func _ready() -> void:
	GameData.game_state = Enums.GAME_STATES.COMBAT
	_create_enemy_displays()

func _create_enemy_displays():
	var formation := CombatManager.get_enemy_formation()
	for i in CombatManager.get_enemy_formation().size():
		var enemy := formation[i]
		if enemy == null: continue

		var d = CHARACTER_DISPLAY.instantiate()
		d.slot = i
		d.character = enemy
		d.is_hero = false
		enemy_slots.get_child(i).add_child(d)
