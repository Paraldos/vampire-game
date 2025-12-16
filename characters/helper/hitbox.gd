extends Area2D
class_name Hitbox

var dmg = 0

func _ready() -> void:
	get_child(0).disabled = true

func enable() -> void:
	get_child(0).disabled = false
	await get_tree().create_timer(0.1).timeout
	get_child(0).disabled = true
