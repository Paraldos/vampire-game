extends CanvasLayer

@onready var paragraph: Label = %paragraph
@onready var option_btns: HBoxContainer = %option_btns
var current_dialog
var option_btn_bp = preload("res://dialog_controller/dialog_option_btn.tscn")

func _ready() -> void:
	paragraph.text = current_dialog.paragraph_text
	_add_btns()

func _add_btns():
	for btn in option_btns.get_children():
		btn.queue_free()
	for option in current_dialog.options:
		var btn = option_btn_bp.instantiate()
		btn.text = option.btn_text
		option_btns.add_child(btn)
