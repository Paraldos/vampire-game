extends Resource
class_name CombatAction

@export var img: Texture2D
@export var description := ""

@export_group("use")
@export var target_dmg := 0.0
@export var self_dmg := 0.0
@export var restore_armor := 0.0

@export_group("Animation")
const ACTION_DURATION := 0.6
@export var user_animation := Enums.ANIMATIONS.NONE
@export var target_animation := Enums.ANIMATIONS.NONE

# =================================================== text
func get_action_name() -> String:
	return Utils.id_to_txt(resource_path.get_file().get_basename()).to_upper()

func get_description() -> String:
	var arr: Array[String] = []
	if !description.is_empty():
		arr.append(description)
	if target_dmg != 0.0:
		arr.append("Deal %d%% damage to the target." % roundi(target_dmg * 100.0))
	if self_dmg != 0.0:
		arr.append("Lose %d%% of your maximum health (this bypasses armor)." % roundi(self_dmg * 100.0))
	if restore_armor != 0.0:
		arr.append("Restore %d%% of your maximum armor." % roundi(restore_armor * 100.0))
	return "\n".join(arr)

# =================================================== use
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

	_deal_dmg_to_target(user_is_player)
	_deal_dmg_to_yourself(user_is_player)
	_restore_armor(user_is_player)

	await Utils.create_timer(ACTION_DURATION)
	CombatManager.next_turn()

func _deal_dmg_to_target(user_is_player: bool) -> void:
	if user_is_player:
		var dmg = PlayerManager.attack + Utils.roll_dice()
		CombatManager.enemy.deal_dmg(dmg * target_dmg)
	else:
		var dmg = CombatManager.enemy.attack + Utils.roll_dice()
		PlayerManager.deal_dmg(dmg * target_dmg)

func _deal_dmg_to_yourself(user_is_player: bool) -> void:
	if user_is_player:
		var dmg = PlayerManager.max_hp * self_dmg
		PlayerManager.deal_dmg(dmg, true)
	else:
		var dmg = CombatManager.enemy.max_hp * self_dmg
		CombatManager.enemy.deal_dmg(dmg, true)

func _restore_armor(user_is_player: bool) -> void:
	if user_is_player:
		var amount = PlayerManager.max_armor * restore_armor
		PlayerManager.restore_armor(amount)
	else:
		var amount = CombatManager.enemy.max_armor * restore_armor
		CombatManager.enemy.restore_armor(amount)
