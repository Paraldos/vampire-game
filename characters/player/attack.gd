extends State

@onready var hitbox_melee: Hitbox = %HitboxMelee
@onready var muzzle_container: Node2D = %MuzzleContainer
@onready var muzzle: Marker2D = %Muzzle

@onready var bow_attack: Node2D = %BowAttack
@onready var sword_attack: Node2D = %SwordAttack
@onready var unarmed_attack: Node2D = %UnarmedAttack
var target_pos : Vector2
var arrow_bp := preload("res://characters/projectiles/arrow.tscn")
var wait_for_attack := false

func _ready() -> void:
	Signals.shift_click.connect(_start_attack)
	Signals.chase_attack.connect(_start_attack)
	hitbox_melee.get_child(0).disabled = true

func physics_tick(_delta: float) -> void:
	if wait_for_attack and not character.animating:
		_start_attack(character.attack_target.global_position)

func _start_attack(new_target_pos : Vector2):
	state_machine.change_state('Attack')
	if character.animating:
		wait_for_attack = true
	else:
		target_pos = new_target_pos
		character.animating = true
		_middle_attack()

func _middle_attack():
	character.character_sprite.attack_animation(target_pos)
	if character.player_weapon == null:
		await _unarmed_attack()
	else:
		match character.player_weapon.attack_animation:
			GlobalEnums.AttackAnimation.BOW:
				await _bow_attack()
			GlobalEnums.AttackAnimation.SWORD:
				await _sword_attack()
	_end_attack()

func _end_attack() -> void:
	character.animating = false
	state_machine.change_state('Idle')

# ============================== helper
func enable_melee_hitbox(dmg : int) -> void:
	hitbox_melee.look_at(target_pos)
	hitbox_melee.dmg = dmg
	hitbox_melee.get_child(0).disabled = false
	await get_tree().create_timer(0.1).timeout
	hitbox_melee.get_child(0).disabled = true

# ============================== attacks
func _unarmed_attack():
	enable_melee_hitbox(PlayerProfile.attack)
	await unarmed_attack.play(target_pos)
	return

func _bow_attack():
	muzzle_container.look_at(target_pos)
	var arrow :Projectile = arrow_bp.instantiate()
	arrow.global_position = muzzle.global_position
	arrow.collision_mask = 9
	arrow.dmg = PlayerProfile.attack
	arrow.look_at(target_pos)
	get_tree().current_scene.add_child(arrow)
	await bow_attack.play(target_pos)
	return

func _sword_attack():
	enable_melee_hitbox(PlayerProfile.attack)
	await sword_attack.play(target_pos)
	return
