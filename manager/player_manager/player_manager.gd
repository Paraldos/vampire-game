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
static func deal_dmg(dmg: int, bypass_armor := false) -> void:
	if dmg <= 0: return
	if bypass_armor:
		current_hp = maxi(current_hp - dmg, 0)
	else:
		var remaining_damage := maxi(dmg - current_armor, 0)
		current_armor = maxi(current_armor - dmg, 0)
		current_hp = maxi(current_hp - remaining_damage, 0)

static func restore_armor(amount) -> void:
	current_armor = mini(current_armor + amount, max_armor)
