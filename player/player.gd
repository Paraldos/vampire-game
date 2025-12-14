extends Node2D

@onready var camera: Camera2D = %Camera2D

var path : Array[Vector2]
var current_target: Vector2
var speed := 80.0
var moving := false

func _ready() -> void:
	_init_camera()

func _init_camera():
	var rect: Rect2i = Utils.map.get_used_rect()
	var tile_size := Utils.map.tile_set.tile_size.x
	camera.limit_left   = rect.position.x * tile_size
	camera.limit_top    = rect.position.y * tile_size
	camera.limit_right  = rect.end.x * tile_size
	camera.limit_bottom = rect.end.y * tile_size

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed('left_click'):
		_on_left_click()
	if not moving and path.size() > 0:
		current_target = path.pop_front()
		moving = true
	if moving:
		_move(delta)

func _on_left_click():
	# player tile
	var player_tile: Vector2i = Utils.map.local_to_map(global_position)
	if path.size() > 0: player_tile = Utils.map.local_to_map(path[0])
	# clicked tile
	var clicked_tile: Vector2i = Utils.map.local_to_map(get_global_mouse_position())
	# path
	var tile_path: Array[Vector2i] = Utils.map.get_astar_path(player_tile, clicked_tile)
	path.clear()
	for tile in tile_path:
		path.append(Utils.map.map_to_local(tile))
	if path.size() > 0 and global_position.distance_to(path[0]) < 1.0:
		path.pop_front()

func _move(delta: float) -> void:
	global_position = global_position.move_toward(current_target, speed * delta)
	if global_position.distance_to(current_target) < 0.01:
		global_position = current_target
		moving = false
