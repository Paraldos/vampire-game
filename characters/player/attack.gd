extends State

@onready var hitbox_melee: Hitbox = %HitboxMelee
@onready var bow_attack: Node2D = %BowAttack
@onready var sword_attack: Node2D = %SwordAttack
@onready var unarmed_attack: Node2D = %UnarmedAttack
var target_pos : Vector2

func _ready() -> void:
	Signals.shift_click.connect(_attack)
	Signals.chase_attack.connect(_attack)

func _attack(new_target_pos : Vector2) -> void:
	_start_attack_basics(new_target_pos)
	var player_weapon :ItemInstance = PlayerProfile.inventory[GlobalEnums.ItemSlots.MAINHAND]
	if player_weapon == null:
		await _unarmed_attack()
	else:
		match player_weapon.attack_animation:
			GlobalEnums.AttackAnimation.BOW:
				await _bow_attack()
			GlobalEnums.AttackAnimation.SWORD:
				await _sword_attack()
	_end_attack_basics()

func _start_attack_basics(new_target_pos : Vector2) -> void:
	target_pos = new_target_pos
	state_machine.change_state('Attack')
	character.animating = true
	character.character_sprite.attack_animation(target_pos)

func _end_attack_basics() -> void:
	character.animating = false
	state_machine.change_state('Idle')

# ============================== attacks
func _unarmed_attack():
	hitbox_melee.look_at(target_pos)
	hitbox_melee.enable()
	unarmed_attack.play(target_pos)
	await unarmed_attack.finished
	return

func _bow_attack():
	bow_attack.play(target_pos)
	await bow_attack.finished
	return

func _sword_attack():
	hitbox_melee.look_at(target_pos)
	hitbox_melee.enable()
	sword_attack.play(target_pos)
	await sword_attack.finished
	return
