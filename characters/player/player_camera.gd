extends Camera2D

func _ready() -> void:
	var rect: Rect2i = Utils.map.get_used_rect()
	var tile_size := Utils.map.tile_set.tile_size.x
	limit_left   = rect.position.x * tile_size
	limit_top    = rect.position.y * tile_size
	limit_right  = rect.end.x * tile_size
	limit_bottom = rect.end.y * tile_size
