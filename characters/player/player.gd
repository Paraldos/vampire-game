extends CharacterTemplate

@onready var character_sprite_container: Node2D = %CharacterSpriteContainer
@onready var character_sprite: Sprite2D = %CharacterSprite
@onready var sword_animation: Node2D = %SwordAnimation
@onready var hitbox: Hitbox = $Hitbox
@onready var state_machine: StateMachine = %StateMachine

func _ready() -> void:
	super()
	state_machine.setup(self)

func _physics_process(delta: float) -> void:
	super(delta)
	state_machine.physics_tick(delta)
	if Input.is_action_pressed('left_click') and Input.is_action_pressed('shift'):
		_shift_click()

func _shift_click():
	if animating: return
	_attack(get_global_mouse_position())

func _attack(target_position : Vector2):
	animating = true
	character_sprite.attack_animation(target_position)
	hitbox.look_at(target_position)
	hitbox.enable()
	sword_animation.look_at(target_position)
	sword_animation.play()
	await sword_animation.finished
	animating = false
