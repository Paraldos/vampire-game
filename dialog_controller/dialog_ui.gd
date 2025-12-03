extends CanvasLayer

@onready var paragraph: Label = %paragraph
@onready var option_btns: HBoxContainer = %option_btns
var current_dialog
var option_btn_bp = preload("res://dialog_controller/dialog_btn.tscn")

func _ready() -> void:
	SignalController.change_dialog.connect(_on_change_dialog)
	SignalController.end_dialog.connect(_on_end_dialog)
	_update_text()
	_update_btns()
	get_tree().paused = true

func _on_end_dialog():
	get_tree().paused = false
	queue_free()

func _on_change_dialog(new_dialog):
	current_dialog = new_dialog
	_update_text()
	_update_btns()

func _update_text():
	paragraph.text = current_dialog.paragraph_text

func _update_btns():
	for btn in option_btns.get_children():
		btn.queue_free()
	for option in current_dialog.options:
		var btn = option_btn_bp.instantiate()
		btn.option = option
		option_btns.add_child(btn)
	if current_dialog.options.size() == 0:
		var btn = option_btn_bp.instantiate()
		option_btns.add_child(btn)
