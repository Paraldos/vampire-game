extends Resource
class_name Conversation

@export var character_name := ""
@export_multiline var greeting := ""
@export var topics: Array[ConversationTopic] = []

@export_storage var current_output := ""
@export_storage var suggestions: Array[String] = []

func init() -> void:
	current_output = greeting

func get_id() -> StringName:
	return StringName(resource_path)
