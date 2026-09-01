extends Resource
class_name ConversationTopic

@export var key := "":
	get:
		return _normalize(key)
@export_multiline var response := ""

func _normalize(text: String) -> String:
	return text.strip_edges().to_lower()
