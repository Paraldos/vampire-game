extends State

@export var min_wait_time := 3.0
@export var max_wait_time := 5.0
@export var roam_radius := 3
var target_cell : Vector2i

func enter() -> void:
	super()
	_start_timer()

func physics_tick(delta: float) -> void:
	if not character.animating and character.path.size() > 0:
		if not character._is_next_step_valid():
			character.path = Utils.get_astar_path(character.occupied_cell, target_cell)
		if character.path.size() > 0:
			character._start_moving(character.path.pop_front())
	elif character.animating:
		character.move(delta)

func _start_timer():
	var wait_time := character.rng.randf_range(min_wait_time, max_wait_time)
	await get_tree().create_timer(wait_time).timeout
	target_cell = get_random_cell_in_circle()
	character.path = Utils.get_astar_path(character.occupied_cell, target_cell)
	_start_timer()

func get_random_cell_in_circle(radius: int = 5, max_tries: int = 30) -> Vector2i:
	for i in max_tries:
		var dx := character.rng.randi_range(-radius, radius)
		var dy := character.rng.randi_range(-radius, radius)
		if dx * dx + dy * dy > radius * radius:
			continue
		var cell : Vector2i = character.spawn_cell + Vector2i(dx, dy)
		if not Utils.map.astar_grid.is_point_solid(cell):
			return cell
	return character.spawn_cell
