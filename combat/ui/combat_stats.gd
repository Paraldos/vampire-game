extends VBoxContainer

enum SIDE {PLAYER, ENEMY}

@onready var hp_label: Label = %HPLabel
@onready var armor_label: Label = %ArmorLabel
@onready var attack_label: Label = %AttackLabel
@onready var container: Array[HBoxContainer] = [
	$HPContainer,
	$ArmorContainer,
	$AttackContainer
]
@export var side = SIDE.PLAYER

var char

func _ready() -> void:
	GlobalSignals.update_combat_stats.connect(_update)
	if side == SIDE.PLAYER:
		char = PlayerManager
	else:
		char = CombatManager.enemy
	for c in container:
		if side == SIDE.PLAYER:
			c.alignment = BoxContainer.ALIGNMENT_BEGIN
		else:
			c.alignment = BoxContainer.ALIGNMENT_END
			c.move_child(c.get_child(0), c.get_child_count() - 1)
	_update()

func _update():
	hp_label.text = "%s/%s" % [
		char.current_hp, char.max_hp]
	armor_label.text = "%s/%s" % [
		char.current_armor, char.max_armor]
	attack_label.text = "%s" % char.attack
