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

func can_target(target_is_hero: bool, target_is_frontline: bool) -> bool:
	if target_is_hero:
		if target_is_frontline:
			return hero_targets & FRONTLINE != 0
		else:
			return hero_targets & BACKLINE != 0
	else:
		if target_is_frontline:
			return enemy_targets & FRONTLINE != 0
		else:
			return enemy_targets & BACKLINE != 0

func can_use(target: Character) -> bool:
	return target != null

func use(target: Character) -> void:
	print("%s used on %s" % [title, target.name])
