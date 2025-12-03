extends Area2D

signal action

func _ready() -> void:
	visible = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("action") && visible:
		action.emit()

func _on_body_entered(body: Node2D) -> void:
	visible = true

func _on_body_exited(body: Node2D) -> void:
	visible = false
