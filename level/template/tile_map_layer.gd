extends TileMapLayer

@onready var line_2d: Line2D = $Line2D

const BUILDING_SOURCE_ID: int = 3
var astar_grid

func _ready() -> void:
	Utils.map = self
	_init_astar()

func _init_astar():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = Rect2i(get_used_rect())
	astar_grid.cell_size = Vector2i(16,16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.update()
	for cell: Vector2i in get_used_cells():
		var cell_source_id: int = get_cell_source_id(cell)
		if cell_source_id == BUILDING_SOURCE_ID:
			astar_grid.set_point_solid(cell)

func _update_visible_path(path):
	var new_points: PackedVector2Array = []
	for point in path:
		new_points.append(point * 16)
	line_2d.points = new_points

func get_astar_path(start_cell, target_cell) -> Array[Vector2i]:
	var path = astar_grid.get_id_path(start_cell, target_cell)
	if start_cell == target_cell:
		path = [] as Array[Vector2i]
	# _update_visible_path(path)
	return path
