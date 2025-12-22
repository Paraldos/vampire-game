extends Node

@onready var item_db: Node = %ItemDB
@onready var affix_db: Node = %AffixDB

var rng = RandomNumberGenerator.new()
var item_keys: Array[StringName] = []
var affix_keys: Array[StringName] = []
var quality_to_amount_of_affixes := {
	GlobalEnums.ItemQuality.COMMON: 0,
	GlobalEnums.ItemQuality.MAGIC: 1,
	GlobalEnums.ItemQuality.RARE: 2,
	GlobalEnums.ItemQuality.LEGENDARY: 3
}
const MAGIC_THRESHOLD := 40
const RARE_THRESHOLD := 70
const LEGENDARY_THRESHOLD := 90

func get_quality_color(quality := 0):
	var colors = [
		Color("ebede9"),
		Color("73bed3"),
		Color("de9e41"),
		Color("a53030")
	]
	return colors[quality]

func _ready() -> void:
	rng.randomize()
	item_keys.clear()
	for child in item_db.get_children():
		if child is Item:
			item_keys.append(child.name)
	affix_keys.clear()
	for child in affix_db.get_children():
		if child is Affix:
			affix_keys.append(child.name)
	_generat_randome_item()

func get_item(id: StringName) -> Item:
	return item_db.get_node_or_null(String(id)) as Item

func get_affix(id: StringName) -> Affix:
	return affix_db.get_node_or_null(String(id)) as Affix

func get_item_texture(id: StringName) -> Texture2D:
	var item = get_item(id)
	return item.texture

func get_item_texture_size(id: StringName) -> Vector2:
	var texture = get_item_texture(id)
	return round(texture.get_size() / 16)

func get_randome_texture_frame(id: StringName) -> int:
	var texture_size = get_item_texture_size(id)
	return rng.randi_range(0, texture_size.x + texture_size.y)

func get_random_texture_frame(id: StringName) -> int:
	var size := get_item_texture_size(id)
	var frame_count :int = round(size.x * size.y)
	return rng.randi_range(0, frame_count - 1)

func _generat_randome_item() -> ItemInstance:
	var item_id = _roll_random_item_id()
	var item = get_item(item_id)
	var quality = _roll_random_quality(1)
	var amount_of_affixes = quality_to_amount_of_affixes[quality]
	var affixes = _roll_random_affixes(amount_of_affixes, item)
	var item_instance = ItemInstance.new()
	var texture_frame = get_randome_texture_frame(item_id)
	item_instance.item_id = item_id
	item_instance.quality = quality
	item_instance.affixes = affixes
	item_instance.texture_frame = texture_frame
	return item_instance

func _roll_random_item_id() -> StringName:
	return item_keys[rng.randi_range(0, item_keys.size() - 1)]

func _roll_random_quality(player_level : int) -> int:
	var quality_factor = rng.randi_range(0, 50 + player_level)
	if quality_factor < MAGIC_THRESHOLD:
		return GlobalEnums.ItemQuality.COMMON
	elif quality_factor < RARE_THRESHOLD:
		return GlobalEnums.ItemQuality.MAGIC
	elif quality_factor < LEGENDARY_THRESHOLD:
		return GlobalEnums.ItemQuality.RARE
	else:
		return GlobalEnums.ItemQuality.LEGENDARY

func _roll_random_affixes(amount_of_affixes: int, item: Item) -> Array[Dictionary]:
	var rolls: Array[Dictionary] = []
	if amount_of_affixes <= 0:
		return rolls
	var keys: Array[StringName] = affix_keys.duplicate()
	keys.shuffle()
	var index := 0
	while rolls.size() < amount_of_affixes and index < keys.size():
		var affix_id := keys[index]
		index += 1
		var affix := get_affix(affix_id)
		if affix == null:
			continue
		if item.type not in affix.allowed_types:
			continue
		var value := rng.randi_range(affix.min_value, affix.max_value)
		rolls.append({ "id": affix_id, "value": value })
	return rolls
