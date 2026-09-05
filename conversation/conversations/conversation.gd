extends Resource
class_name Conversation

@export var character_name := ""
@export var img : Texture2D
@export_multiline var greeting := ""
@export var topics: Array[ConversationTopic] = []

@export_storage var current_output := ""

func init() -> void:
	change_output(greeting)

func get_id() -> StringName:
	return StringName(resource_path)

func get_used_keys():
	var arr: Array[String] = []
	for topic in topics:
		if !topic.used: continue
		if !topic.requirement_met(): continue
		arr.push_back(topic.key)
	return arr

func get_suggested_keys():
	var arr: Array[String] = []
	for topic in topics:
		if !topic.suggested: continue
		if topic.used: continue
		if !topic.requirement_met(): continue
		arr.push_back(topic.key)
	return arr

func change_output(new_output: String) -> void:
	current_output = new_output
	var nText = Utils.normalize_txt(current_output)
	for topic in topics:
		if topic.suggested or topic.used:
			continue
		var nKey = Utils.normalize_txt(topic.key)
		if nText.contains(nKey):
			topic.suggested = true
