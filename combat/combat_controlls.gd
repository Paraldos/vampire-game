extends MarginContainer

func _ready() -> void:
	GlobalSignals.activate_character.connect(_on_activate_character)

func _on_activate_character(activted_character : Character):
	print(activted_character)
