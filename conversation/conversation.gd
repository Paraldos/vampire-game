extends Resource
class_name Conversation

@export var character_name := ""
@export_multiline var greeting := ""
@export_storage var current_output := ""
@export var topics: Array[ConversationTopic] = []
@export_storage var suggested_keys: Array[String] = []
@export_storage var used_keys: Array[String] = []

func init() -> void:
	current_output = greeting

func get_id() -> StringName:
	return StringName(resource_path)

func get_topic_by_key(key: String) -> ConversationTopic:
	for topic in topics:
		if Utils.normalize_txt(topic.key) == Utils.normalize_txt(key):
			return topic
	return null

func add_key_to_used(key: String) -> void:
	var normalized_key = Utils.normalize_txt(key)
	for used_key in used_keys:
		if Utils.normalize_txt(used_key) == normalized_key:
			return
	used_keys.append(key)
	for suggested_key in suggested_keys:
		if Utils.normalize_txt(suggested_key) == normalized_key:
			suggested_keys.erase(suggested_key)
			break

func check_text_for_keys() -> void:
	var keys = get_all_keys()
	var normalize_txt = Utils.normalize_txt(current_output)
	var words = normalize_txt.split(" ", false)

	for key in keys:
		if used_keys.has(key) or suggested_keys.has(key):
			continue
		var normalized_key = Utils.normalize_txt(key)
		var key_words = normalized_key.split(" ", false)
		var key_word_count = key_words.size()
		if words.size() < key_word_count:
			continue
		for i in range(words.size() - key_word_count + 1):
			var window_phrase = ""
			for j in range(key_word_count):
				if j > 0:
					window_phrase += " "
				window_phrase += words[i + j]
			if abs(window_phrase.length() - normalized_key.length()) > 1:
				continue
			if window_phrase.similarity(normalized_key) >= 0.75:
				suggested_keys.push_back(key)
				break

func get_all_keys() -> Array[String]:
	var arr: Array[String] = []
	for topic in topics:
		arr.push_back(topic.key)
	return arr
