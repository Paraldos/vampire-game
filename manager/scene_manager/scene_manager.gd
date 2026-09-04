extends CanvasLayer

@onready var background: ColorRect = %Background

const COMBAT_WINDOW = preload("uid://dqqin61d3ow2p")

var fade_time := 0.4
var fade_color := Color("06080a")
var clear_color := Color("ffffff00")
var current_overlay_scene: Node = null
var old_game_state : Enums.GAME_STATES

func _ready() -> void:
	background.modulate = clear_color

# ============================================================= change scene
func change_scene(new_scene: PackedScene) -> void:
	Utils.game_data.game_state = Enums.GAME_STATES.CHANGE_SCENE
	get_tree().paused = true
	await _tween_background(fade_color)

	get_tree().change_scene_to_packed(new_scene)
	await get_tree().scene_changed

	await _tween_background(clear_color)
	get_tree().paused = false
	await get_tree().create_timer(0.1).timeout

# ============================================================= overlay
func push_overlay_scene(overlay_scene: PackedScene) -> void:
	old_game_state = Utils.game_data.game_state
	Utils.game_data.game_state = Enums.GAME_STATES.CHANGE_SCENE
	await _tween_background(fade_color)

	get_tree().current_scene.process_mode = PROCESS_MODE_DISABLED
	get_tree().current_scene.hide()
	current_overlay_scene = overlay_scene.instantiate()
	get_tree().root.add_child(current_overlay_scene)

	await _tween_background(clear_color)

func pop_overlay_scene() -> void:
	await _tween_background(fade_color)

	if current_overlay_scene:
		current_overlay_scene.queue_free()
		current_overlay_scene = null
	get_tree().current_scene.show()
	get_tree().current_scene.process_mode = PROCESS_MODE_INHERIT

	await _tween_background(clear_color)
	Utils.game_data.game_state = old_game_state

# ============================================================= helper
func _tween_background(target_value: Color) -> void:
	var tween := create_tween()
	tween.tween_property(background, "modulate", target_value, fade_time)
	await tween.finished
