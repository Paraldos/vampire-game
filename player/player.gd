extends Node2D

var path : Array[Vector2]
var current_target: Vector2
var speed := 80.0
var moving := false

func _ready() -> void:
	SignalController.left_click_enemy.connect(_on_left_click_enemy)
	SignalController.left_clicked_floor.connect(_on_left_clicked_floor)

func _physics_process(delta: float) -> void:
	# if Input.is_action_just_pressed('left_click'):
	# 	_on_left_click()
	if not moving and path.size() > 0:
		current_target = path.pop_front()
		moving = true
	if moving:
		_move(delta)

func _on_left_clicked_floor(target_cell):
	var tile_path = _get_tile_path(target_cell)
	path = _tile_path_to_cell_path(tile_path)

func _on_left_click_enemy(enemy : Enemy):
	path = _get_path_to_target(enemy.global_position)

func _move(delta: float) -> void:
	global_position = global_position.move_toward(current_target, speed * delta)
	if global_position.distance_to(current_target) < 0.01:
		global_position = current_target
		moving = false

# ========================================= Helper
func _get_tile_path(target_cell) -> Array[Vector2i]:
	var player_cell: Vector2i = Utils.map.local_to_map(global_position)
	if path.size() > 0:
		player_cell = Utils.map.local_to_map(path[0])
	return Utils.map.get_astar_path(player_cell, target_cell)

func _get_path(target_position) -> Array[Vector2]:
	var tile_path = _get_tile_path(Utils.map.local_to_map(target_position))
	return _tile_path_to_cell_path(tile_path)

func _tile_path_to_cell_path(tile_path : Array[Vector2i]):
	var pos_path : Array[Vector2]
	for tile in tile_path:
		pos_path.append(Utils.map.map_to_local(tile))
	if pos_path.size() > 0 and global_position.distance_to(pos_path[0]) < 1.0:
		pos_path.pop_front()
	return pos_path

func _get_path_to_target(target_pos : Vector2) -> Array[Vector2]:
	var player_cell: Vector2i = Utils.map.local_to_map(global_position) 
	var target_cell = Utils.map.local_to_map(target_pos)
	var surronding_cells = [
		target_cell + Vector2i(1,0),
		target_cell + Vector2i(-1,0),
		target_cell + Vector2i(0,1),
		target_cell + Vector2i(0,-1),
	]
	if surronding_cells.has(player_cell):
		return [] as Array[Vector2]
	var best_path: Array[Vector2i] = []
	for cell in surronding_cells:
		if not Utils.map.astar_grid.region.has_point(cell):
			continue
		if Utils.map.astar_grid.is_point_solid(cell):
			continue
		var p: Array[Vector2i] = _get_tile_path(cell)
		if p.is_empty():
			continue
		if best_path.size() == 0 or p.size() < best_path.size():
			best_path = p
	return _tile_path_to_cell_path(best_path)