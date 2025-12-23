extends State

@export var hitbox : Hitbox
@export var animation : AttackAnimation

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	hitbox.disable()

func enter() -> void:
	character.animating = true
	enable_hitbox()
	await animation.play(Utils.player.global_position)
	await get_tree().create_timer(0.6).timeout
	character.animating = false
	state_machine.change_state('Chase')

func enable_hitbox():
	hitbox.enable(Utils.player.global_position, 15)
	await get_tree().create_timer(0.1).timeout
	hitbox.disable()
