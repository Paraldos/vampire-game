extends CharacterBody2D

@onready var sprite_parent: Node2D = %SpriteParent
@onready var sprite: Sprite2D = %Sprite
@onready var down: RayCast2D = %Down
@onready var up: RayCast2D = %Up
@onready var right: RayCast2D = %Right
@onready var left: RayCast2D = %Left

var move_direction := Vector2.ZERO

func _ready() -> void:
	pass
