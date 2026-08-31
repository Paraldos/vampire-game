extends PanelContainer
# character stats

enum SIDE {
	PLAYER,
	ENEMY
}

@onready var hp_label: Label = %HPLabel
@onready var armor_label: Label = %ArmorLabel
@onready var attack_label: Label = %AttackLabel

@export var side = SIDE.PLAYER

var char

func _ready() -> void:
	GlobalSignals.update_combat_stats.connect(_update)
	if side == SIDE.PLAYER:
		char = GameData.player_manager
	else:
		char = GameData.combat_manager.enemy
	_update()

func _update():
	hp_label.text = "%s/%s" % [
		char.current_hp, char.max_hp]
	armor_label.text = "%s/%s" % [
		char.current_armor, char.max_armor]
	attack_label.text = "%s" % char.attack
