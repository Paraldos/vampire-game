extends Control

var npc_sprite_scene: PackedScene = load("uid://dxlp1v0lnd5lo")
var player_sprite_scene: PackedScene = load("uid://bqanfgag7n4dy")
@onready var center_position: Marker2D = $CenterPosition
@onready var group_positions: Array[Marker2D] = [
	$GroupPosition1,
	$GroupPosition2,
	$GroupPosition3,
]
@export var player_display := true

func _ready() -> void:
	await get_tree().create_timer(0.3).timeout

	if player_display:
		_add_sprite(player_sprite_scene, center_position)
		return

	var is_enemy_group: bool = (
		Utils.game_data.game_state == Enums.GAME_STATES.COMBAT
		and CombatManager.enemy.group)

	if is_enemy_group:
		for position in group_positions:
			_add_sprite(npc_sprite_scene, position)
	else:
		_add_sprite(npc_sprite_scene, center_position)

func _add_sprite(scene: PackedScene, parent: Node) -> void:
	parent.add_child(scene.instantiate())
