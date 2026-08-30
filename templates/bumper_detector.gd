extends Area2D
class_name BumperDetector

const COLLIDER_RADIUS := 4.0
const DETECTION_DISTANCE := 16.0

@export var actor: CharacterBody2D
var collider : CollisionShape2D

func _init() -> void:
	collision_layer = 0
	collision_mask = 0
	set_collision_mask_value(3, true)

	var circle := CircleShape2D.new()
	circle.radius = COLLIDER_RADIUS

	collider = CollisionShape2D.new()
	collider.shape = circle
	add_child(collider)

func check_collisions() -> void:
	collider.position = actor.move_direction * DETECTION_DISTANCE
	await get_tree().physics_frame
	for collision in get_overlapping_bodies():
		if collision is Bumper:
			collision.bump()
			return
