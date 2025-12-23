extends Area2D
class_name Hitbox

var dmg := 0

func _on_area_entered(area: Area2D) -> void:
	if not area is Hurtbox: return
	area.take_dmg(dmg)
