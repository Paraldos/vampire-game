extends State

@onready var hitbox_melee: Hitbox = %HitboxMelee
@onready var muzzle_container: Node2D = %MuzzleContainer
@onready var muzzle: Marker2D = %Muzzle

@onready var bow_attack: Node2D = %BowAttack
@onready var sword_attack: Node2D = %SwordAttack
@onready var unarmed_attack: Node2D = %UnarmedAttack
var target_pos : Vector2
var arrow_bp := preload("res://characters/projectiles/arrow.tscn")

func _ready() -> void:
	Signals.shift_click.connect(_attack)
	Signals.chase_attack.connect(_attack)
	hitbox_melee.get_child(0).disabled = true

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

func enable_melee_hitbox() -> void:
	hitbox_melee.look_at(target_pos)
	hitbox_melee.get_child(0).disabled = false
	await get_tree().create_timer(0.1).timeout
	hitbox_melee.get_child(0).disabled = true

# ============================== attacks
func _unarmed_attack():
	enable_melee_hitbox()
	unarmed_attack.play(target_pos)
	await unarmed_attack.finished
	return

func _bow_attack():
	muzzle_container.look_at(target_pos)
	var arrow :Projectile = arrow_bp.instantiate()
	arrow.global_position = muzzle.global_position
	arrow.collision_layer = 3
	arrow.collision_mask = 3
	arrow.pierce = 0
	arrow.look_at(target_pos)
	get_tree().current_scene.add_child(arrow)

	bow_attack.play(target_pos)
	await bow_attack.finished
	return

func _sword_attack():
	enable_melee_hitbox()
	sword_attack.play(target_pos)
	await sword_attack.finished
	return
