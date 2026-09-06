extends State

@onready var sprite_parent: Node2D = %SpriteParent
@onready var spawn_animation: Node2D = %SpawnAnimation

func start():
	spawn_animation.play()
	await spawn_animation.halfpoint
	sprite_parent.visible = true
	await spawn_animation.finished
	await get_tree().physics_frame
	transition_to(&"Idle")
