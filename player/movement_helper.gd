extends Node2D

func get_tile_path(target_cell) -> Array[Vector2i]:
	var player_cell: Vector2i = Utils.map.local_to_map(global_position)
	return Utils.map.get_astar_path(player_cell, target_cell)

func get_position_path(target_position) -> Array[Vector2]:
	var tile_path = get_tile_path(Utils.map.local_to_map(target_position))
	return tile_path_to_cell_path(tile_path)

func tile_path_to_cell_path(tile_path : Array[Vector2i]):
	var pos_path : Array[Vector2]
	for tile in tile_path:
		pos_path.append(Utils.map.map_to_local(tile))
	if pos_path.size() > 0 and global_position.distance_to(pos_path[0]) < 1.0:
		pos_path.pop_front()
	return pos_path

func get_path_to_target(target_pos : Vector2) -> Array[Vector2]:
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
		var p: Array[Vector2i] = get_tile_path(cell)
		if p.is_empty():
			continue
		if best_path.size() == 0 or p.size() < best_path.size():
			best_path = p
	return tile_path_to_cell_path(best_path)
