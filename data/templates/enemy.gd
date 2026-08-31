extends Resource
class_name Enemy

@export var name: String
@export var actions: Array[Action] = []

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

func deal_damage(amount: int) -> void:
	if amount <= 0: return
	var remaining_damage := maxi(
		amount - current_armor, 0)
	current_armor = maxi(
		current_armor - amount, 0)
	current_hp = maxi(
		current_hp - remaining_damage, 0)
