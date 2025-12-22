extends State

@onready var bow_attack: Node2D = %BowAttack
@onready var sword_attack: Node2D = %SwordAttack

func _ready() -> void:
	Signals.shift_click.connect(_on_shift_click)
	Signals.chase_attack.connect(_on_chase_attack)

func _on_chase_attack(target_pos : Vector2) -> void:
	_sword_attack(target_pos)
	state_machine.change_state('Attack')

func _on_shift_click(target_pos : Vector2) -> void:
	_sword_attack(target_pos)
	state_machine.change_state('Attack')

# ============================== attacks
func _start_attack_basics(target_position : Vector2):
	character.animating = true
	character.character_sprite.attack_animation(target_position)

func _end_attack_basics():
	character.animating = false
	state_machine.change_state('Idle')

func _bow_attack(target_position : Vector2):
	_start_attack_basics(target_position)
	_end_attack_basics()

func _sword_attack(target_position : Vector2):
	_start_attack_basics(target_position)
	character.hitbox.look_at(target_position)
	character.hitbox.enable()
	sword_attack.play(target_position)
	await character.sword_animation.finished
	_end_attack_basics()
