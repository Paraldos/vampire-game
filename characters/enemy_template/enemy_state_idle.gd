extends EnemyState

var timer :Timer
@export var min_wait_time := 3.0
@export var max_wait_time := 5.0
@export var roam_radius := 3

func enter() -> void:
	super()
	if timer == null:
		timer = Timer.new()
		timer.one_shot = true
		add_child(timer)
	_start_timer()

func exit() -> void:
	if timer: timer.stop()

func physics_tick(_delta: float) -> void:
	if timer.time_left > 0: return
	character.path = Utils.get_astar_path(character.occupied_cell, get_random_cell_in_circle())
	_start_timer()

func _start_timer():
	var wait_time := character.rng.randf_range(min_wait_time, max_wait_time)
	timer.start(wait_time)

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
