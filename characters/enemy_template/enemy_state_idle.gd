extends EnemyState

func enter() -> void:
	super()

func exit() -> void:
	super()

func physics_tick(delta: float) -> void:
	super(delta)
	if enemy.target != null:
		state_machine.change_state("Chase")
