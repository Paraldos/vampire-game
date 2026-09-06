extends CharacterBody2D

@onready var sprite_parent: Node2D = %SpriteParent
@onready var main_sprite: Sprite2D = %MainSprite

@onready var player_area: Area2D = %PlayerArea
@onready var encounter_detector: Area2D = %EncounterDetector
@onready var down: RayCast2D = %Down
@onready var up: RayCast2D = %Up
@onready var right: RayCast2D = %Right
@onready var left: RayCast2D = %Left

var move_direction := Vector2.ZERO
