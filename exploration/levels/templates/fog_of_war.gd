extends TileMapLayer

const SOURCE_ID := 0

const UNKNOWN_TILE := Vector2i(0, 0)
const FOG_TILE := Vector2i(1, 0)
const VISIBLE_TILE := Vector2i(2, 0)

@export var active := true

var map_rect: Rect2i
var visible_cells: Array[Vector2i] = []

func _ready() -> void:
	GlobalSignals.map_created.connect(_on_map_rect)
	GlobalSignals.reveal_cells.connect(_on_reveal_cells)

func _on_map_rect(new_map_rect: Rect2i) -> void:
	if not active:
		return
	map_rect = new_map_rect
	visible_cells.clear()
	clear()
	for x in range(map_rect.position.x, map_rect.end.x):
		for y in range(map_rect.position.y, map_rect.end.y):
			var cell := Vector2i(x, y)
			set_cell(cell, SOURCE_ID, UNKNOWN_TILE)

func _on_reveal_cells(cells: Array[Vector2i]) -> void:
	if not active:
		return
	for cell in visible_cells:
		set_cell(cell, SOURCE_ID, FOG_TILE)
	visible_cells.clear()
	for cell in cells:
		if not map_rect.has_point(cell):
			continue
		set_cell(cell, SOURCE_ID, VISIBLE_TILE)
		visible_cells.append(cell)
