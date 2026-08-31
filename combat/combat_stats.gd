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
	GlobalSignals.update_combat_stats.connect(_update)
	if side == SIDE.PLAYER:
		char = PlayerManager
	else:
		char = CombatManager.enemy
	_update()

func _update():
	hp_label.text = "%s/%s" % [
		char.current_hp, char.max_hp]
	attack_label.text = "%s" % char.attack
	defense_label.text = "%s" % char.defense
