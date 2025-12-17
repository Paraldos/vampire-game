extends Node

var map : TileMapLayer

func pos_to_cell(pos : Vector2) -> Vector2i:
	return map.local_to_map(pos)

func cell_to_pos(cell) -> Vector2:
	return map.map_to_local(cell)