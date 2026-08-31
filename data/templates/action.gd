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
	GameData.combat_manager.next_turn()

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
		var dmg = GameData.player_manager.attack + Utils.roll_dice()
		GameData.combat_manager.enemy.deal_damage(dmg)
	else:
		var dmg = GameData.combat_manager.enemy.attack + Utils.roll_dice()
		GameData.player_manager.deal_damage(dmg)
	await Utils.get_tree().create_timer(ACTION_DURATION).timeout
