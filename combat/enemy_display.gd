extends Node2D

@onready var single_sprite: Sprite2D = %SingleSprite
@onready var group_sprites: Array[Sprite2D] = [
	%GroupSprite1,
	%GroupSprite2,
	%GroupSprite3
]

func _ready() -> void:
	var enemy = CombatManager.enemy
	single_sprite.texture = enemy.get_random_sprite()
	single_sprite.visible = !enemy.group
	for sprite in group_sprites:
		sprite.texture = enemy.get_random_sprite()
		sprite.visible = enemy.group

func _process(delta: float) -> void:
	pass
