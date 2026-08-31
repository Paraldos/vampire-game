extends PanelContainer
# character stats

enum SIDE {
	PLAYER,
	ENEMY
}

@onready var hp_label: Label = %HPLabel
@onready var attack_label: Label = %AttackLabel
@onready var defense_label: Label = %DefenseLabel

@export var side = SIDE.PLAYER

var char

func _ready() -> void:
	if side == SIDE.PLAYER:
		char = PlayerManager
	else:
		char = CombatManager.enemy
	hp_label.text = "%s/%s" % [
		char.current_hp, char.max_hp]
	attack_label.text = "%s" % char.get_attack()
	defense_label.text = "%s" % char.get_defense()
