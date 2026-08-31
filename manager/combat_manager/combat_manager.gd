extends Resource
class_name CombatManager

const VICTORY_MODAL = preload("uid://dyjcj21csd2cj")
const DEFEAT_MODAL = preload("uid://byeowkfa6q0er")

@export_storage var enemy: Enemy
@export_storage var player_turn := true

# ======================================== controlls
func start_combat(new_enemy: Enemy) -> void:
	if new_enemy == null:
		push_error("Cannot start combat without an enemy.")
		return
	player_turn = true
	enemy = new_enemy.duplicate(true) as Enemy
	enemy.current_hp = enemy.max_hp
	SceneManager.change_scene(SceneManager.COMBAT_WINDOW)

func end_combat() -> void:
	enemy = null

func next_turn() -> void:
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

func _defeat():
	ModalManager.open_modal(DEFEAT_MODAL)

func _victory():
	ModalManager.open_modal(VICTORY_MODAL)

# ======================================== helper
func _get_instance() -> CombatManager:
	return GameData.save_game.combat_manager
