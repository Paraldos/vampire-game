extends State

@onready var bow_attack: Node2D = %BowAttack
@onready var sword_attack: Node2D = %SwordAttack
@onready var hitbox_sword: Hitbox = %HitboxSword
var target_pos : Vector2

func _ready() -> void:
	Signals.shift_click.connect(_attack)
	Signals.chase_attack.connect(_attack)

func _attack(new_target_pos : Vector2) -> void:
	target_pos = new_target_pos
	state_machine.change_state('Attack')
	_start_attack_basics()
	var player_weapon_instance :ItemInstance = PlayerProfile.inventory[GlobalEnums.ItemSlots.MAINHAND]
	var player_weapon :Item = LootSystem.get_item(player_weapon_instance.item_id)
	match player_weapon.attack_animation:
		GlobalEnums.AttackAnimation.BOW:
			await _bow_attack()
		GlobalEnums.AttackAnimation.SWORD:
			await _sword_attack()
	_end_attack_basics()

func _start_attack_basics():
	character.animating = true
	character.character_sprite.attack_animation(target_pos)

func _end_attack_basics():
	character.animating = false
	state_machine.change_state('Idle')

# ============================== attacks
func _bow_attack():
	bow_attack.play(target_pos)
	await bow_attack.finished
	return

func _sword_attack():
	hitbox_sword.look_at(target_pos)
	hitbox_sword.enable()
	sword_attack.play(target_pos)
	await sword_attack.finished
	return
