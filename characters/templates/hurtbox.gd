extends Area2D
class_name Hurtbox

signal hit(dmg : int)

func take_dmg(dmg : int):
	hit.emit(dmg)
