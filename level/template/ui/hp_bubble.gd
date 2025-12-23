extends TextureProgressBar

func _ready() -> void:
	_update()
	Signals.update_hp.connect(_update)

func _update():
	max_value = PlayerProfile.hp_max
	value = PlayerProfile.hp_current
