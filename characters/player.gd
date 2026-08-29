extends CharacterBody2D

enum State {
	IDLE,
	MOVE,
	BUMP,
}

@onready var sprite_parent: Node2D = %SpriteParent
@onready var sprite: Sprite2D = %Sprite
@onready var down: RayCast2D = %Down
@onready var up: RayCast2D = %Up
@onready var right: RayCast2D = %Right
@onready var left: RayCast2D = %Left

const TILE_SIZE := Vector2(16, 16)
const MOVEMENT_DURATION := 0.3
const JUMP_HEIGHT := 1.5
const BUMP_DURATION := 0.3
const BUMP_REACH := 3.0

var busy = false
var state := State.IDLE

func _physics_process(_delta: float) -> void:
	match state:
		State.IDLE:
			_process_idle()
		State.MOVE:
			pass
		State.BUMP:
			pass
func _process_idle() -> void:
	var direction := _get_input_direction()

	if direction == Vector2.ZERO:
		return

	if _is_blocked(direction):
		_start_bump(direction)
	else:
		_start_move(direction)

func _get_input_direction() -> Vector2:
	if Input.is_action_pressed("left"):
		return Vector2.LEFT
	if Input.is_action_pressed("right"):
		return Vector2.RIGHT
	if Input.is_action_pressed("up"):
		return Vector2.UP
	if Input.is_action_pressed("down"):
		return Vector2.DOWN

	return Vector2.ZERO


func _is_blocked(direction: Vector2) -> bool:
	match direction:
		Vector2.LEFT:
			return left.is_colliding()
		Vector2.RIGHT:
			return right.is_colliding()
		Vector2.UP:
			return up.is_colliding()
		Vector2.DOWN:
			return down.is_colliding()

	return false

func _try_move(direction: Vector2, raycast: RayCast2D) -> void:
	if raycast.is_colliding():
		_bump(direction)
	else:
		_move(direction)

func _bump(direction: Vector2) -> void:
	busy = true
	await _animation_bump(direction)
	busy = false

func _animation_bump(direction: Vector2) -> void:
	var tween := create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(
		sprite_parent,
		"position",
		direction * BUMP_REACH,
		BUMP_DURATION / 2.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		sprite_parent,
		"position",
		Vector2.ZERO,
		BUMP_DURATION / 2.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await tween.finished

func _move(direction: Vector2) -> void:
	busy = true
	global_position += direction * TILE_SIZE
	sprite_parent.position -= direction * TILE_SIZE
	_animation_hop()
	await _animation_move()
	busy = false

func _animation_move() -> void:
	var tween := create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(
		sprite_parent,
		"position",
		Vector2.ZERO,
		MOVEMENT_DURATION
	).set_trans(Tween.TRANS_SINE)
	await tween.finished
	return

func _animation_hop() -> void:
	var tween := create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(
		sprite,
		"position:y",
		-JUMP_HEIGHT,
		MOVEMENT_DURATION / 2.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		sprite,
		"position:y",
		0.0,
		MOVEMENT_DURATION / 2.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
