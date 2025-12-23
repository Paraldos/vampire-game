extends State

@onready var range_checker: RayCast2D = %RangeChecker
@onready var melee_checker: Area2D = %MeleeChecker

var target_cell:
	get:
		return character.attack_target.occupied_cell
var target_pos:
	get:
		return Utils.cell_to_pos(character.attack_target.occupied_cell)

func _ready() -> void:
	Signals.left_click_enemy.connect(_on_left_click_enemy)

func physics_tick(delta: float) -> void:
	if not character.animating:
		if _check_if_enemy_is_in_range():
			Signals.chase_attack.emit(target_pos)
			return
		if character.attack_target.occupied_cell != target_cell:
			character.path = get_path_to_target()
		if not character._is_next_step_valid():
			character.path = get_path_to_target()
		if character.path.size() > 0:
			character.start_moving(character.path.pop_front())
		else:
			state_machine.change_state('Idle')
	elif character.animating:
		character.move(delta)

func _check_if_enemy_is_in_range() -> bool:
	var player_weapon : ItemInstance = PlayerProfile.inventory[GlobalEnums.ItemSlots.MAINHAND]
	if player_weapon == null or player_weapon.attack_range == GlobalEnums.AttackRange.MELEE:
		return melee_checker.has_overlapping_areas()
	else:
		range_checker.target_position = target_pos - global_position
		return not range_checker.is_colliding()

func _on_left_click_enemy(target : CharacterTemplate) -> void:
	if Input.is_action_pressed('ui_shift'): return
	character.attack_target = target
	character.path = get_path_to_target()
	state_machine.change_state('Chase')

func get_path_to_target() -> Array[Vector2i]:
	var surronding_cells = Utils.map.get_surrounding_cells(target_cell)
	var best_path: Array[Vector2i] = []
	for cell in surronding_cells:
		if not Utils.map.astar_grid.region.has_point(cell):
			continue
		if Utils.map.astar_grid.is_point_solid(cell):
			continue
		var path: Array[Vector2i] = Utils.get_astar_path(occupied_cell, cell)
		if path.is_empty():
			continue
		if best_path.size() == 0 or path.size() < best_path.size():
			best_path = path
	return best_path
