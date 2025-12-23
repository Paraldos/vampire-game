extends Node2D
class_name Projectile

@onready var hitbox: Hitbox = %Hitbox
@onready var liftetime_timer: Timer = %LiftetimeTimer

@export var speed: float = 150.0
@export var max_range: float = 300.0
@export var lifetime: float = 0.0

@export var dmg: int = 5
@export var knockback: float = 0.0

@export var pierce: int = 0
@export_flags_2d_physics var collision_mask: int
@export var impact_bp : PackedScene

var dir: Vector2 = Vector2.RIGHT
var traveled: float = 0.0
var hits: int = 0
var source: Node = null
var dying: bool = false

func _ready() -> void:
	hitbox.collision_mask = collision_mask
	hitbox.dmg = dmg
	if lifetime:
		liftetime_timer.start(lifetime)

func _physics_process(delta: float) -> void:
	var step := speed * delta
	var direction := Vector2.RIGHT.rotated(global_rotation)
	global_position += direction * step
	_update_range(step)

func _update_range(step : float) -> void:
	traveled += step
	if max_range > 0.0 and traveled >= max_range:
		queue_free()

func _on_liftetime_timer_timeout() -> void:
	queue_free()

func _on_hitbox_area_entered(_area: Area2D) -> void:
	hits += 1
	if pierce <= 0 or hits > pierce: die()

func _on_hitbox_body_entered(_body: Node2D) -> void:
	die()

func die() -> void:
	if dying: return
	dying = true
	_spawn_impact()
	queue_free()

func _spawn_impact() -> void:
	if not impact_bp: return
	var impact := impact_bp.instantiate() as Node2D
	impact.global_position = global_position
	impact.global_rotation = global_rotation
	get_tree().root.add_child(impact)
