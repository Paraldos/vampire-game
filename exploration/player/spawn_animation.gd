extends Node2D

signal halfpoint
signal finished
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func play():
	await get_tree().physics_frame
	animation_player.play("spawn")
	return
