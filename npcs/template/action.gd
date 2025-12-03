extends Area2D

signal action

func _ready() -> void:
	visible = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("action") && visible:
		action.emit()

func _on_body_entered(_body: Node2D) -> void:
	visible = true

func _on_body_exited(_body: Node2D) -> void:
	visible = false
