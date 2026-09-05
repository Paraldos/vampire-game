@tool
extends Node

const FLOATING_MESSAGE = preload("uid://cakdlilotuy2i")
var rng = RandomNumberGenerator.new()
var game_data = GameData.new()

func _ready() -> void:
	rng.randomize()

func clear_container(container : Control):
	for child in container.get_children():
		child.queue_free()

func roll_dice(sides := 6) -> int:
	var dice = rng.randi_range(1, sides)
	return dice

func normalize_txt(text: String) -> String:
	return text.strip_edges().to_lower()

func spawn_floating_message(txt: String, pos: Vector2):
	var m = FLOATING_MESSAGE.instantiate()
	m.text = txt
	m.global_position = pos
	get_tree().current_scene.add_child(m)
	LevelManager.respawn_level = LevelManager.current_level
