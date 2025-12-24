extends Sprite2D

@onready var character_sprite: Sprite2D = %CharacterSprite
@export var character : CharacterTemplate

var hit_time := 0.2
var hit_scale := Vector2(1.3, 1.3)
var shake_strength := 3.0
var shake_interval := 0.1
var shake_timer := 0.0

func _ready() -> void:
	self.material = self.material.duplicate()

func _on_hurtbox_hit() -> void:
	_enable_hit_sprite(true)
	_on_hit_shake()
	_on_hit_scale()
	_on_hit_color()
	await get_tree().create_timer(hit_time).timeout
	_enable_hit_sprite(false)

func _enable_hit_sprite(new_value : bool):
	visible = new_value
	character_sprite.visible = !new_value

func _on_hit_shake() -> void:
	position = Vector2(
		randf_range(-shake_strength, shake_strength),
		randf_range(-shake_strength, shake_strength)
	)

func _on_hit_scale():
	scale = hit_scale
	await get_tree().create_timer(hit_time/2).timeout
	var t := create_tween()
	t.tween_property(self, 'scale', Vector2(1,1), hit_time / 2)

func _on_hit_color() -> void:
	var mat := self.material as ShaderMaterial
	mat.set_shader_parameter("new_color_1", Color.WHITE)
	mat.set_shader_parameter("new_color_2", Color.WHITE)
	await get_tree().create_timer(hit_time/2).timeout
	var t := create_tween()
	t.tween_method(
		func(c: Color) -> void: mat.set_shader_parameter("new_color_1", c),
		Color.WHITE,
		character.color_default,
		hit_time / 2
	)
	t.parallel()
	t.tween_method(
		func(c: Color) -> void: mat.set_shader_parameter("new_color_2", c),
		Color.WHITE,
		Color("090a14"),
		hit_time
	)
