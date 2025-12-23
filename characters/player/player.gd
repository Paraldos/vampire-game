extends CharacterTemplate

var player_weapon : ItemInstance:
	get: return PlayerProfile.inventory[GlobalEnums.ItemSlots.MAINHAND]
var current_state :String :
	get: return state_machine.current_state.name

func _ready() -> void:
	super()
	state_machine.setup(self)

func _physics_process(delta: float) -> void:
	super(delta)
	state_machine.physics_tick(delta)
	if Input.is_action_pressed('ui_left_click') and Input.is_action_pressed('ui_shift'):
		if animating: return
		Signals.shift_click.emit(get_global_mouse_position())
