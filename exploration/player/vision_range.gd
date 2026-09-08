extends Node2D

@onready var vision_casts: Array[RayCast2D] = [
	%VisionCast1,
	 %VisionCast2,
	 %VisionCast3,
	 %VisionCast4
]
@export var vision_range := 3

func reveal() -> void:
	var center_cell := ExplorationManager.pos_to_cell(global_position)
	var revealed_cells: Dictionary[Vector2i, bool] = {}
	for x in range(-vision_range, vision_range + 1):
		for y in range(-vision_range, vision_range + 1):
			var target_cell := center_cell + Vector2i(x, y)
			if not _can_see_cell(target_cell):
				continue
			revealed_cells[target_cell] = true
	var visible_cells: Array[Vector2i] = []
	visible_cells.assign(revealed_cells.keys())
	GlobalSignals.reveal_cells.emit(visible_cells)

func _can_see_cell(cell: Vector2i) -> bool:
	var target_pos := ExplorationManager.cell_to_pos_center(cell)
	for cast in vision_casts:
		cast.target_position = cast.to_local(target_pos)
		cast.force_raycast_update()
		if not cast.is_colliding():
			return true
		var direction := (target_pos - cast.global_position).normalized()
		var collision_pos := (
			cast.get_collision_point()
			+ direction * 0.1)
		var collision_cell := ExplorationManager.pos_to_cell(collision_pos)
		if collision_cell == cell:
			return true
	return false
