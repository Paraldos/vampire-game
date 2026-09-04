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
	CombatManager.next_turn()

func _slash(user_is_player: bool) -> void:
	GlobalSignals.display_animation.emit(
		user_is_player,
		Enums.ANIMATIONS.ATTACK,
		ACTION_DURATION
	)
	GlobalSignals.display_animation.emit(
		!user_is_player,
		Enums.ANIMATIONS.HIT,
		ACTION_DURATION
	)
	if user_is_player:
		var dmg = PlayerManager.attack + Utils.roll_dice()
		CombatManager.enemy.deal_damage(dmg)
	else:
		var dmg = CombatManager.enemy.attack + Utils.roll_dice()
		PlayerManager.deal_damage(dmg)
	await Utils.get_tree().create_timer(ACTION_DURATION).timeout
