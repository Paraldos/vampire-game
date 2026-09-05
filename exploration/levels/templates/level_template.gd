extends Node2D
# level template

@onready var spawn_points: Node2D = %SpawnPoints
@onready var player_container: Node2D = %PlayerContainer

const PLAYER = preload("uid://uuu0f4178hm5")

func _ready() -> void:
	GlobalSignals.spawn_player.connect(_on_spawn_player)
	GlobalSignals.trigger_spawn_point.connect(_on_trigger_spawn_point)
	Utils.game_data.game_state = Enums.GAME_STATES.EXPLORE

func _on_trigger_spawn_point(idx):
	if idx < 0:
		return
	var spawn_point
	if idx >= 0 and idx < spawn_points.get_child_count():
		spawn_point = spawn_points.get_child(idx)
	else:
		spawn_point = spawn_points.get_child(0)
	_on_spawn_player(spawn_point.global_position)

func _on_spawn_player(pos):
	var p = PLAYER.instantiate()
	p.global_position = pos
	player_container.add_child(p)
