extends Resource
class_name ConversationTopic

@export var key := ""
@export_multiline var output := ""

func get_normalized_key():
	return key.strip_edges().to_lower()
