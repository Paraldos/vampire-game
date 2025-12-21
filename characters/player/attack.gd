extends State

func _ready() -> void:
	SignalController.shift_click.connect(_on_shift_click)
	SignalController.chase_attack.connect(_on_chase_attack)

func _on_chase_attack(target_pos : Vector2) -> void:
	_sword_attack(target_pos)
	state_machine.change_state('Attack')

func _on_shift_click(target_pos : Vector2) -> void:
	_sword_attack(target_pos)
	state_machine.change_state('Attack')

func _sword_attack(target_position : Vector2):
	character.animating = true
	# charackter sprite
	character.character_sprite.attack_animation(target_position)
	# hitbox
	character.hitbox.look_at(target_position)
	character.hitbox.enable()
	# sword animation
	character.sword_animation.look_at(target_position)
	character.sword_animation.play()
	# finish
	await character.sword_animation.finished
	character.animating = false
	state_machine.change_state('Idle')
