extends Resource
class_name CombatManager

const VICTORY_MODAL = preload("uid://dyjcj21csd2cj")
const DEFEAT_MODAL = preload("uid://byeowkfa6q0er")

# ======================================== set / get
static var player_turn : bool:
	get:
		return Utils.game_data.player_turn
	set(value):
		Utils.game_data.player_turn = value

static var enemy : Enemy:
	get:
		return Utils.game_data.enemy
	set(value):
		Utils.game_data.enemy = value

# ======================================== controlls
static func start_combat(new_enemy: Enemy) -> void:
	if new_enemy == null:
		push_error("Cannot start combat without an enemy.")
		return
	player_turn = true
	enemy = new_enemy.duplicate(true) as Enemy
	enemy.current_hp = enemy.max_hp
	SceneManager.push_overlay_scene(SceneManager.COMBAT_WINDOW)

static func end_combat() -> void:
	enemy = null
	SceneManager.pop_overlay_scene()

static func next_turn() -> void:
	GlobalSignals.update_combat_stats.emit()
	player_turn = !player_turn

	if PlayerManager.current_hp == 0:
		_defeat()
	elif enemy.current_hp == 0:
		_victory()
	elif player_turn:
		GlobalSignals.enable_action_btns.emit()
	else:
		await Utils.get_tree().create_timer(0.5).timeout
		enemy.use_randome_action()

static func _defeat():
	ModalManager.open_modal(DEFEAT_MODAL)

static func _victory():
	ModalManager.open_modal(VICTORY_MODAL)
