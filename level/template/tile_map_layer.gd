extends TileMapLayer

@onready var line_2d: Line2D = $Line2D

const BUILDING_SOURCE_ID: int = 3
const BUILDING_RIM_ATLAS: Vector2i = Vector2i(0, 0)
const BUILDING_RIM_REPLACEMENT_ATLAS: Vector2i = Vector2i(1, 0)
const BUILDING_WALL_ATLAS = Vector2(0,1)
var astar_grid

func _ready() -> void:
	Utils.map = self
	_adjust_building_rim()
	_init_astar()

func _adjust_building_rim() -> void:
	var cells_to_change: Array[Vector2i] = []
	for cell: Vector2i in get_used_cells():
		if not _cell_matches(cell, BUILDING_SOURCE_ID, BUILDING_RIM_ATLAS):
			continue
		var above: Vector2i = cell + Vector2i(0, -1)
		if _cell_matches(above, BUILDING_SOURCE_ID, BUILDING_RIM_ATLAS):
			continue
		cells_to_change.push_back(cell)
	for cell: Vector2i in cells_to_change:
		set_cell(cell, BUILDING_SOURCE_ID, BUILDING_RIM_REPLACEMENT_ATLAS)

func _cell_matches(cell: Vector2i, source_id: int, atlas_coords: Vector2i) -> bool:
	var cell_source_id: int = get_cell_source_id(cell)
	var cell_atlas: Vector2i = get_cell_atlas_coords(cell)
	return cell_source_id == source_id and cell_atlas == atlas_coords

func _init_astar():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = Rect2i(get_used_rect())
	astar_grid.cell_size = Vector2i(16,16)
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	astar_grid.update()
	for cell: Vector2i in get_used_cells():
		if _cell_matches(cell, BUILDING_SOURCE_ID, BUILDING_WALL_ATLAS):
			astar_grid.set_point_solid(cell)
		if _cell_matches(cell, BUILDING_SOURCE_ID, BUILDING_RIM_ATLAS):
			astar_grid.set_point_solid(cell)

func _update_visible_path(path):
	var new_points: PackedVector2Array = []
	for point in path:
		new_points.append(point * 8)
	line_2d.points = new_points

func get_astar_path(start_cell, target_cell):
	var path = astar_grid.get_id_path(start_cell, target_cell)
	_update_visible_path(path)
	return path
