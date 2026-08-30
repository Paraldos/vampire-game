extends Resource
class_name CombatAction

@export var title := ""
@export var img :Texture2D
var active = false

@export_category("Valid Targets")
const FRONTLINE := 1
const BACKLINE := 2

@export_flags("Frontline", "Backline")
var hero_targets := FRONTLINE | BACKLINE

@export_flags("Frontline", "Backline")
var enemy_targets := FRONTLINE | BACKLINE

func select() -> void:
	CombatManager.select_action(self)

func can_target(target_is_hero: bool, frontline: bool) -> bool:
	var valid_targets := hero_targets if target_is_hero else enemy_targets
	var target_line := FRONTLINE if frontline else BACKLINE
	return valid_targets & target_line != 0

func can_use(target: Character) -> bool:
	return target != null

func use(target: Character) -> void:
	print("%s used on %s" % [title, target.name])
