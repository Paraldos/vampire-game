extends Resource
class_name Combat

const COMBAT_SIZE := 4
const FRONTLINE_SLOTS := [0, 1]
const BACKLINE_SLOTS := [2, 3]

@export_storage var enemy_formation: Array[Enemy] = []
@export_storage var battle_sequence: Array[Character] = []
@export_storage var current_turn := -1

@export var potential_enemies: Array[Enemy]
@export var active_character : Character

func create_enemy_formation() -> void:
	enemy_formation = [
		_get_randome_enemy(Enums.COMBAT_POSITION.FRONTLINE),
		_get_randome_enemy(Enums.COMBAT_POSITION.FRONTLINE),
		_get_randome_enemy(Enums.COMBAT_POSITION.BACKLINE),
		_get_randome_enemy(Enums.COMBAT_POSITION.BACKLINE),
	]

func _get_randome_enemy(position := Enums.COMBAT_POSITION.FRONTLINE) -> Enemy:
	potential_enemies.shuffle()
	for enemy in potential_enemies:
		if enemy == null: continue
		if enemy.prefered_position == position:
			return enemy.duplicate(true)
	return null

func create_sequence() -> void:
	battle_sequence.clear()
	# for enemy in enemy_formation:
	# 	if enemy != null:
	# 		battle_sequence.append(enemy)
	for hero in PlayerManager.hero_formation:
		if hero != null:
			battle_sequence.append(hero)
	battle_sequence.shuffle()
	current_turn = -1

func next_turn() -> void:
	current_turn += 1
	if current_turn >= battle_sequence.size():
		current_turn = 0
	active_character = battle_sequence[current_turn]
	GlobalSignals.activate_character.emit(active_character)
