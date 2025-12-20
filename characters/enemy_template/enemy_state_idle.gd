extends EnemyState

func enter() -> void:
	super()
	_wandering_timer()

func _wandering_timer() -> void:
	var wait_time = character.rng.randi_range(1, 3)
	await get_tree().create_timer(wait_time).timeout
	character.path = [_get_random_neighbour_cell()]
	_wandering_timer()

func _get_random_neighbour_cell() -> Vector2i:
	var neighbors := Utils.map.get_surrounding_cells(character.occupied_cell)
	return neighbors[character.rng.randi_range(0, neighbors.size() - 1)]
