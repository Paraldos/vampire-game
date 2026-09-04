extends Resource
class_name PlayerManager

# ======================================== set / get
static var max_hp: int:
	set(value):
		GameData.save_game.max_hp = value
	get:
		return GameData.save_game.max_hp

static var current_hp: int:
	set(value):
		GameData.save_game.current_hp = value
	get:
		return GameData.save_game.current_hp

static var max_armor: int:
	set(value):
		GameData.save_game.max_armor = value
	get:
		return GameData.save_game.max_armor

static var current_armor: int:
	set(value):
		GameData.save_game.current_armor = value
	get:
		return GameData.save_game.current_armor

static var attack: int:
	set(value):
		GameData.save_game.attack = value
	get:
		return GameData.save_game.attack

static var actions: Array[Action]:
	set(value):
		GameData.save_game.actions = value
	get:
		return GameData.save_game.actions

# ======================================== helper
static func deal_damage(amount: int) -> void:
	var remaining_damage := maxi(amount - current_armor, 0)
	current_armor = maxi(current_armor - amount, 0)
	current_hp = maxi(current_hp - remaining_damage, 0)
