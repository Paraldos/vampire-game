extends Resource
class_name Action

enum TYPE {
	UNKNOWN,
	SLASH,
	HEAL,
	DEFEND
}

const ACTION_DURATION = 0.6

@export var type: TYPE
var name: String:
	get:
		return TYPE.keys()[type].capitalize()
@export var img :Texture2D

func can_be_used(_user_is_player : bool) -> bool:
	return true

func use(user_is_player : bool) -> void:
	if !can_be_used(user_is_player): return
	GlobalSignals.disable_action_btns.emit()
	match type:
		TYPE.SLASH:
			await _slash(user_is_player)
		_:
			pass
	GlobalSignals.update_combat_stats.emit()
	if user_is_player:
		CombatManager.enemy_turn()
	else:
		GlobalSignals.enable_action_btns.emit()

func _slash(user_is_player: bool) -> void:
	GlobalSignals.play_combat_animation.emit(
		user_is_player,
		Enums.COMBAT_ANIMATIONS.ATTACK
	)
	GlobalSignals.play_combat_animation.emit(
		!user_is_player,
		Enums.COMBAT_ANIMATIONS.HIT
	)
	if user_is_player:
		var dmg = PlayerManager.attack + Utils.roll_dice()
		var defense = CombatManager.enemy.defense
		CombatManager.enemy.current_hp -= maxi(dmg - defense, 0)
	else:
		var dmg = CombatManager.enemy.attack + Utils.roll_dice()
		var defense = PlayerManager.defense
		PlayerManager.current_hp -= maxi(dmg - defense, 0)
	await Utils.get_tree().create_timer(ACTION_DURATION).timeout
