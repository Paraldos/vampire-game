extends Node2D

@onready var vision_cast: RayCast2D = %VisionCast

var vision_range := 3

func reveal() -> void:
	var center_tile := ExplorationManager.pos_to_tile(global_position)
	var cells: Array[Vector2i] = []
	for x in range(-vision_range, vision_range + 1):
		for y in range(-vision_range, vision_range + 1):
			var target_tile := center_tile + Vector2i(x, y)
			if _can_see_tile(target_tile):
				cells.append(target_tile)
	GlobalSignals.reveal_cells.emit(cells)

func _can_see_tile(target_tile: Vector2i) -> bool:
	var target_pos := ExplorationManager.tile_to_center_pos(target_tile)
	vision_cast.target_position = vision_cast.to_local(target_pos)
	vision_cast.force_raycast_update()
	if not vision_cast.is_colliding():
		return true
	var direction := (target_pos - vision_cast.global_position).normalized()
	var collision_position := (vision_cast.get_collision_point() + direction * 0.5)
	var collision_tile := ExplorationManager.pos_to_tile(collision_position)
	return collision_tile == target_tile
