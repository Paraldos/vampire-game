extends Resource
class_name PlayerManager

# ======================================== export function
@export var max_hp := 20
@export_storage var current_hp := max_hp

@export var max_armor := 20
@export_storage var current_armor := max_armor

@export var attack := 10

@export var actions :Array[Action] = [
	load("res://data/actions/slash.tres"),
	load("res://data/actions/defend.tres")
]

# ======================================== helper
func deal_damage(amount: int) -> void:
	var remaining_damage := maxi(amount - current_armor, 0)
	current_armor = maxi(current_armor - amount, 0)
	current_hp = maxi(current_hp - remaining_damage, 0)

func get_actions():
	return _get_instance().actions

func _get_instance() -> PlayerManager:
	return GameData.save_game.player_manager
