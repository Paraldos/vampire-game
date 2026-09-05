extends Resource
class_name PlayerManager

# ======================================== set / get
static var max_hp: int:
	set(value):
		Utils.game_data.max_hp = value
	get:
		return Utils.game_data.max_hp

static var current_hp: int:
	set(value):
		Utils.game_data.current_hp = value
	get:
		return Utils.game_data.current_hp

static var max_armor: int:
	set(value):
		Utils.game_data.max_armor = value
	get:
		return Utils.game_data.max_armor

static var current_armor: int:
	set(value):
		Utils.game_data.current_armor = value
	get:
		return Utils.game_data.current_armor

static var attack: int:
	set(value):
		Utils.game_data.attack = value
	get:
		return Utils.game_data.attack

static var actions: Array[CombatAction]:
	set(value):
		Utils.game_data.actions = value
	get:
		return Utils.game_data.actions

# ======================================== helper
static func deal_damage(amount: int) -> void:
	var remaining_damage := maxi(amount - current_armor, 0)
	current_armor = maxi(current_armor - amount, 0)
	current_hp = maxi(current_hp - remaining_damage, 0)
