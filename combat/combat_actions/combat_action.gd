extends Resource
class_name CombatAction

enum TYPE {
	UNKNOWN,
	SLASH,
	HEAL,
	DEFEND
}

@export var type: TYPE
@export var img :Texture2D

@export_group("Animation")
const ACTION_DURATION = 0.6
@export var user_animation := Enums.ANIMATIONS.NONE
@export var target_animation = Enums.ANIMATIONS.NONE

func get_action_name():
	return TYPE.keys()[type].capitalize()

func can_be_used(_user_is_player : bool) -> bool:
	return true

func use(user_is_player : bool) -> void:
	if !can_be_used(user_is_player):
		return
	GlobalSignals.disable_action_btns.emit()
	GlobalSignals.display_animation.emit(
		user_is_player, user_animation, ACTION_DURATION)
	GlobalSignals.display_animation.emit(
		!user_is_player, target_animation, ACTION_DURATION)
	match type:
		TYPE.SLASH:
			await _slash(user_is_player)
		_:
			pass
	CombatManager.next_turn()

func _slash(user_is_player: bool) -> void:
	if user_is_player:
		var dmg = PlayerManager.attack + Utils.roll_dice()
		CombatManager.enemy.deal_damage(dmg)
	else:
		var dmg = CombatManager.enemy.attack + Utils.roll_dice()
		PlayerManager.deal_damage(dmg)
	await Utils.get_tree().create_timer(ACTION_DURATION).timeout
