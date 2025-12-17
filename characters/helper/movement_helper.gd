extends Node2D

var character_cell : Vector2i :
	get: return Utils.pos_to_cell(global_position)

func _target_is_neighbour(target_pos : Vector2):
	var target_cell = Utils.pos_to_cell(target_pos)
	var surronding_cells = Utils.map.get_surrounding_cells(target_cell)
	return surronding_cells.has(character_cell)

func get_path_to_target(target_pos : Vector2) -> Array[Vector2i]:
	var target_cell = Utils.pos_to_cell(target_pos)
	var surronding_cells = Utils.map.get_surrounding_cells(target_cell)
	if _target_is_neighbour(target_pos):
		return [] as Array[Vector2i]
	var best_path: Array[Vector2i] = []
	for cell in surronding_cells:
		if not Utils.map.astar_grid.region.has_point(cell):
			continue
		if Utils.map.astar_grid.is_point_solid(cell):
			continue
		var path: Array[Vector2i] = Utils.map.get_astar_path(character_cell, cell)
		if path.is_empty():
			continue
		if best_path.size() == 0 or path.size() < best_path.size():
			best_path = path
	return best_path
