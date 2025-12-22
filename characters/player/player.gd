extends CharacterTemplate

@onready var character_sprite_container: Node2D = %CharacterSpriteContainer
@onready var character_sprite: Sprite2D = %CharacterSprite
@onready var state_machine: StateMachine = %StateMachine

func _ready() -> void:
	super()
	state_machine.setup(self)

func _physics_process(delta: float) -> void:
	super(delta)
	state_machine.physics_tick(delta)
	if Input.is_action_pressed('ui_left_click') and Input.is_action_pressed('ui_shift'):
		if animating: return
		Signals.shift_click.emit(get_global_mouse_position())
