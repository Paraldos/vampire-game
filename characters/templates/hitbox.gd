extends Area2D
class_name Hitbox

var dmg := 0

func _on_area_entered(area: Area2D) -> void:
	if not area is Hurtbox: return
	area.take_dmg(dmg)

func enable(target_pos : Vector2, new_dmg : int) -> void:
	dmg = new_dmg
	look_at(target_pos)
	get_child(0).disabled = false

func disable() -> void:
	get_child(0).disabled = true
