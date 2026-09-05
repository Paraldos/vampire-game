extends Resource
class_name Enemy

@export var name: String
@export var actions: Array[CombatAction] = []

@export_group("Display")
@export var group := false
@export var sprites: Array[Texture2D] = []

@export_group("Stats")
@export var max_hp: int = 10
@export_storage var current_hp: int = 10

@export var max_armor: int = 10
@export_storage var current_armor: int = 10

@export var attack: int = 5

func get_random_sprite() -> Texture2D:
	if sprites.is_empty():
		return null
	return sprites.pick_random()

func use_randome_action():
	actions.shuffle()
	for action in actions:
		if action.can_be_used(false):
			action.use(false)
			return

# ======================================== helper
func deal_dmg(dmg: int, bypass_armor := false) -> void:
	if dmg <= 0: return
	if bypass_armor:
		current_hp = maxi(current_hp - dmg, 0)
	else:
		var remaining_damage := maxi(dmg - current_armor, 0)
		current_armor = maxi(current_armor - dmg, 0)
		current_hp = maxi(current_hp - remaining_damage, 0)

func restore_armor(amount) -> void:
	current_armor = mini(current_armor + amount, max_armor)
