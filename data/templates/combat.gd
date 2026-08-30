extends Resource
class_name Combat

const COMBAT_SIZE := 4
const FRONTLINE_SLOTS := [0, 1]
const BACKLINE_SLOTS := [2, 3]

@export var potential_enemies: Array[Enemy]
@export var enemy_formation: Array[Enemy] = []

func start() -> void:
	_create_enemy_formation()

func _create_enemy_formation() -> void:
	enemy_formation.resize(COMBAT_SIZE)
	enemy_formation.fill(null)
	for i in COMBAT_SIZE:
		var frontline := FRONTLINE_SLOTS.has(i)
		enemy_formation[i] = _create_enemy(frontline)

func _create_enemy(frontline := true) -> Enemy:
	potential_enemies.shuffle()
	for enemy in potential_enemies:
		if enemy != null and enemy.frontline == frontline:
			return enemy.duplicate(true) as Enemy
	return null
