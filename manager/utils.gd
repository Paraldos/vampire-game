extends Node

func clear_container(container : Control):
	for child in container.get_children():
		child.queue_free()
