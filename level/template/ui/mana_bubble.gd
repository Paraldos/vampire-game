extends TextureProgressBar

func _ready() -> void:
	_update()
	Signals.update_mp.connect(_update)

func _update():
	max_value = PlayerProfile.mp_max
	value = PlayerProfile.mp_current