extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func change_scene(new_map : String, target_point = 0) -> void:
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(new_map)
	await get_tree().create_timer(0.1).timeout
	SignalController.spawn_player.emit(target_point)
	animation_player.play_backwards("fade_to_black")
