extends Node

var map : TileMapLayer
var visible_path_bp = preload('res://level/template/visible_path.tscn')

func pos_to_cell(pos : Vector2) -> Vector2i:
	return map.local_to_map(pos)

func cell_to_pos(cell) -> Vector2:
	return map.map_to_local(cell)

func get_astar_path(start_cell, target_cell) -> Array[Vector2i]:
	var path = map.astar_grid.get_id_path(start_cell, target_cell)
	if start_cell == target_cell:
		path = [] as Array[Vector2i]
	return path

func add_visible_path(path):
	var new_points: PackedVector2Array = []
	for point in path:
		new_points.append(cell_to_pos(point))
	var visible_path = visible_path_bp.instantiate()
	visible_path.points = new_points
	get_tree().current_scene.add_child(visible_path)
