extends Line2D

var life_time = 1

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, 'modulate', Color(1.0, 1.0, 1.0, 0.0), life_time)
	await tween.finished
	queue_free()
