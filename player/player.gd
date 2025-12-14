extends Node2D

@export var speed: float = 70.0
var path : Array[Vector2]
var move_speed = 0.2
var moving = false

func _physics_process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_on_left_click()
	if path and not moving:
		_move()

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
	print(tile_path)
	print(path)
	if path.size() > 0 and global_position.distance_to(path[0]) < 0.5:
		path.pop_front()

func _move():
	moving = true
	var target = path.pop_front()
	var tween = create_tween()
	tween.tween_property(self, "global_position", target, move_speed)
	await tween.finished
	moving = false
