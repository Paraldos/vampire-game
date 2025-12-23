extends State

@onready var alarm_area: Area2D = %AlarmArea
@onready var alarm_ray: RayCast2D = %AlarmRay

@export var min_wait_time := 3.0
@export var max_wait_time := 5.0
@export var roam_radius := 3
var target_cell : Vector2i

func enter() -> void:
	super()
	_start_wandering_timer()

func physics_tick(delta: float) -> void:
	if not character.animating and character.path.size() > 0:
		if not character._is_next_step_valid():
			character.path = Utils.get_astar_path(occupied_cell, target_cell)
		if character.path.size() > 0:
			character.start_moving()
	elif character.animating:
		character.move(delta)

func _start_wandering_timer() -> void:
	var wait_time := character.rng.randf_range(min_wait_time, max_wait_time)
	await get_tree().create_timer(wait_time).timeout
	target_cell = get_random_cell_in_circle()
	character.path = Utils.get_astar_path(occupied_cell, target_cell)
	_start_wandering_timer()

func get_random_cell_in_circle(radius: int = 5, max_tries: int = 30) -> Vector2i:
	for i in max_tries:
		var dx := character.rng.randi_range(-radius, radius)
		var dy := character.rng.randi_range(-radius, radius)
		if dx * dx + dy * dy > radius * radius: continue
		var cell : Vector2i = character.spawn_cell + Vector2i(dx, dy)
		if not Utils.map.astar_grid.is_point_solid(cell):
			return cell
	return character.spawn_cell

func _on_alarm_timer_timeout() -> void:
	if not is_active: return
	if not alarm_area.has_overlapping_areas(): return
	var overlapping_area = alarm_area.get_overlapping_areas()[0]
	alarm_ray.target_position = overlapping_area.global_position - global_position
	if alarm_ray.is_colliding(): return
	state_machine.change_state('Chase')
