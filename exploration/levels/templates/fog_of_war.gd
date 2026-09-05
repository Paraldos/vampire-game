extends TileMapLayer

const TERRAIN_SET := 0
const FOG_TERRAIN := 0
const REVEALED_TERRAIN := 1

@export var active := true

func _ready() -> void:
	GlobalSignals.map_created.connect(_on_map_rect)
	GlobalSignals.reveal_cells.connect(_on_reveal_cells)

func _on_map_rect(map_rect: Rect2i) -> void:
	if not active:
		return
	clear()
	var cells: Array[Vector2i] = []
	for x in range(map_rect.position.x, map_rect.end.x):
		for y in range(map_rect.position.y, map_rect.end.y):
			cells.append(Vector2i(x, y))
	set_cells_terrain_connect(cells, TERRAIN_SET, FOG_TERRAIN)


func _on_reveal_cells(cells: Array[Vector2i]) -> void:
	if not active or cells.is_empty():
		return
	set_cells_terrain_connect(cells, TERRAIN_SET, REVEALED_TERRAIN)
