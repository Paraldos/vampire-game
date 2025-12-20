extends Area2D
class_name Hurtbox

signal hit

func _on_area_entered(area: Area2D) -> void:
	if not area is Hitbox: return
	print(area.dmg)
	hit.emit()
