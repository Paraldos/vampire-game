extends Resource
class_name Conversation

@export var character_name := ""
@export var img : Texture2D
@export_multiline var greeting := ""
@export var topics: Array[ConversationTopic] = []

@export_storage var current_output := ""
@export_storage var suggested_keys: Array[String] = []
@export_storage var used_keys: Array[String] = []
@export_storage var list_of_keys: Array[String] = []

func init() -> void:
	change_output(greeting)
	list_of_keys = get_all_keys()

func get_id() -> StringName:
	return StringName(resource_path)

func get_all_keys() -> Array[String]:
	var arr: Array[String] = []
	for topic in topics:
		arr.push_back(topic.key)
	return arr

func append_used_keys(key) -> void:
	if not used_keys.has(key):
		used_keys.append(key)
	suggested_keys.erase(key)

func change_output(new_output: String) -> void:
	current_output = new_output
	var nText = Utils.normalize_txt(current_output)
	for key in get_all_keys():
		var nKey = Utils.normalize_txt(key)
		if nKey.is_empty(): continue
		if not nText.contains(nKey): continue
		if used_keys.has(key): continue
		if suggested_keys.has(key): continue
		suggested_keys.append(key)
