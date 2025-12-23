extends State

@onready var ranged_range_detector: RayCast2D = %RangedRangeDetector
@onready var melee_range_detector: Area2D = %MeleeRangeDetector
@onready var alarm_area: Area2D = %AlarmArea
@onready var chase_timer: Timer = %ChaseTimer

var target: CharacterTemplate:
	get: return Utils.player
var target_cell: Vector2i:
	get: return Utils.player.occupied_cell
var target_pos: Vector2:
	get: return Utils.player.global_position

func enter() -> void:
	chase_timer.start()
	if _check_if_enemy_is_in_range():
		state_machine.change_state('Attack')

func stop() -> void:
	chase_timer.stop()

func physics_tick(delta: float) -> void:
	if not character.animating:
		if _check_if_enemy_is_in_range():
			state_machine.change_state('Attack')
			return
		else:
			character.path = get_path_to_target()
		if character.path.size() > 0:
			character.start_moving()
		else:
			state_machine.change_state('Idle')
	elif character.animating:
		character.move(delta)

func _check_if_enemy_is_in_range() -> bool:
	if character.attack_range == GlobalEnums.AttackRange.MELEE:
		return melee_range_detector.has_overlapping_areas()
	else:
		ranged_range_detector.target_position = target_pos - global_position
		return not ranged_range_detector.is_colliding()

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

func _on_chase_timer_timeout() -> void:
	if alarm_area.has_overlapping_areas: return
	state_machine.change_state('Idle')
