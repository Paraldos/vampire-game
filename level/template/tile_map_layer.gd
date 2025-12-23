extends TileMapLayer

const BUILDING_SOURCE_ID: int = 3
var astar_grid

func _ready() -> void:
	Utils.map = self
	_init_astar()

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed('ui_left_click'):
		var local_mouse := to_local(get_global_mouse_position())
		var cell: Vector2i = local_to_map(local_mouse)
		if not astar_grid.region.has_point(cell): return
		if astar_grid.is_point_solid(cell): return
		Signals.left_clicked_floor.emit(cell)

func _init_astar():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = Rect2i(get_used_rect())
	astar_grid.cell_size = Vector2i(16,16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	astar_grid.update()
	for cell: Vector2i in get_used_cells():
		var cell_source_id: int = get_cell_source_id(cell)
		if cell_source_id == BUILDING_SOURCE_ID:
			astar_grid.set_point_solid(cell)
