extends Area2D
class_name Hurtbox

signal hit

func take_dmg(dmg : int):
	print(dmg)
	hit.emit()
