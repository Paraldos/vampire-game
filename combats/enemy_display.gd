extends Node2D

@onready var single_sprite: CombatSprite = %SingleSprite
@onready var group_sprites: Array[CombatSprite] = [
	%GroupSprite1,
	%GroupSprite2,
	%GroupSprite3
]
var enemy : Enemy

func _ready() -> void:
	enemy = GameData.combat_manager.enemy
	update_sprites()

func update_sprites():
	single_sprite.texture = enemy.get_random_sprite()
	single_sprite.visible = !enemy.group
	for sprite in group_sprites:
		sprite.texture = enemy.get_random_sprite()
		sprite.visible = enemy.group
