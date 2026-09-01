extends Resource
class_name Conversation

@export var character_name := ""
@export var topics: Array[ConversationTopic]
@export_storage var suggestions: Array[String]

func get_id() -> StringName:
	return StringName(resource_path)
