extends TileMapLayer

func _ready() -> void:
	call_deferred("_announce_map_size")

func _announce_map_size() -> void:
	var map_rect := get_used_rect()
	GlobalSignals.map_created.emit(map_rect)
