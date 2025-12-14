extends Node

var tile_map : TileMapLayer
var astar_grid : AStarGrid2D
var visible_path : Line2D

func _update_visible_path(path):
	var new_points: PackedVector2Array = []
	for point in path:
		new_points.append(point * 8)
	visible_path.points = new_points
