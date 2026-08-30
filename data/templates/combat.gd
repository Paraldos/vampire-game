extends Resource
class_name Combat

const COMBAT_SIZE := 4
const FRONTLINE_SLOTS := [0, 1]
const BACKLINE_SLOTS := [2, 3]

@export var potential_enemies: Array[Enemy]
@export var heroes: Array[Hero] = []
@export var enemies: Array[Enemy] = []

func start() -> void:
	_create_enemy_formation()

func _create_enemy_formation() -> void:
	enemies.resize(COMBAT_SIZE)
	enemies.fill(null)
	for i in COMBAT_SIZE:
		var frontline := FRONTLINE_SLOTS.has(i)
		enemies[i] = _get_enemy(frontline)

func _get_enemy(frontline := true) -> Enemy:
	potential_enemies.shuffle()
	for enemy in potential_enemies:
		if enemy != null and enemy.frontline == frontline:
			return enemy.duplicate(true) as Enemy
	return null