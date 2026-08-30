extends Resource
class_name Combat

const COMBAT_SIZE := 4
const FRONTLINE_SLOTS := [0, 1]
const BACKLINE_SLOTS := [2]

@export_storage var enemy_formation: Array[Enemy] = []
@export_storage var battle_sequence: Array[Character] = []
@export_storage var current_turn := -1

@export var potential_enemies: Array[Enemy]
@export var activate_character : Character

func create_enemy_formation() -> void:
	enemy_formation.resize(COMBAT_SIZE)
	enemy_formation.fill(null)
	for i in COMBAT_SIZE:
		var frontline := FRONTLINE_SLOTS.has(i)
		enemy_formation[i] = _get_formation_enemy(frontline)

func _get_formation_enemy(frontline := true) -> Enemy:
	potential_enemies.shuffle()
	for enemy in potential_enemies:
		if enemy != null and enemy.frontline == frontline:
			return enemy.duplicate(true) as Enemy
	return null

func create_sequence() -> void:
	battle_sequence.clear()
	for enemy in enemy_formation:
		if enemy != null:
			battle_sequence.append(enemy)
	for hero in PlayerManager.hero_formation:
		if hero != null:
			battle_sequence.append(hero)
	battle_sequence.shuffle()
	current_turn = -1

func next_turn() -> void:
	current_turn += 1
	if current_turn >= battle_sequence.size():
		current_turn = 0
	activate_character = battle_sequence[current_turn]
	GlobalSignals.activate_character.emit(activate_character)
