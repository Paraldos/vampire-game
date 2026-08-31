extends Resource
class_name CombatManager2

@export_storage var _enemy: Enemy
@export_storage var _player_turn := true

# ======================================== setter/getter
static var enemy: Enemy:
	get:
		return _get_instance()._enemy
	set(value):
		_get_instance()._enemy = value

static var player_turn: bool:
	get:
		return _get_instance()._player_turn
	set(value):
		_get_instance()._player_turn = value

# ======================================== controlls
static func start_combat(new_enemy: Enemy) -> void:
	if new_enemy == null:
		push_error("Cannot start combat without an enemy.")
		return
	player_turn = true
	enemy = new_enemy.duplicate(true) as Enemy
	enemy.current_hp = enemy.max_hp
	SceneManager.change_scene(SceneManager.COMBAT_WINDOW)

static func end_combat() -> void:
	enemy = null

static func next_turn() -> void:
	GlobalSignals.update_combat_stats.emit()
	player_turn = !player_turn

	if GameData.player_manager.current_hp == 0:
		_defeat()
	elif enemy.current_hp == 0:
		_victory()
	elif player_turn:
		GlobalSignals.enable_action_btns.emit()
	else:
		await Utils.get_tree().create_timer(0.5).timeout
		enemy.use_randome_action()

static func _defeat():
	print('defeat')

static func _victory():
	print('victory')

# ======================================== helper
static func _get_instance() -> CombatManager:
	return GameData.save_game.combat_manager
