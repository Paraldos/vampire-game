extends Resource
class_name ConversationManager

const CONVERSATION_WINDOW = preload("uid://cyebgor0m0ncj")

@export_storage var _current_conversation: Conversation
static var current_conversation : Conversation:
	get:
		return _get_instance()._current_conversation
	set(value):
		_get_instance()._current_conversation = value

@export_storage var _known_conversations: Array[Conversation]
static var known_conversations: Array[Conversation]:
	get:
		return _get_instance()._known_conversations
	set(value):
		_get_instance()._known_conversations = value

# ======================================== check for keyword
static func submit_keyword(keyword: String) -> String:
	for topic in current_conversation.topics:
		if topic.key == keyword:
			current_conversation.suggestions.push_back(keyword)
			return topic.response
	return "I don't know anything about that."

# ======================================== start / stop
static func start_conversation(new_conversation: Conversation) -> void:
	var saved_conversation := get_known_conversation(new_conversation)
	if saved_conversation:
		current_conversation = saved_conversation
	else:
		current_conversation = new_conversation
		known_conversations.append(new_conversation)
	SceneManager.push_overlay_scene(CONVERSATION_WINDOW)

static func get_known_conversation(new_conversation: Conversation) -> Conversation:
	for conversation in known_conversations:
		if conversation.get_id() == new_conversation.get_id():
			return conversation
	return null

static func end_conversation() -> void:
	current_conversation = null
	SceneManager.pop_overlay_scene()

# ======================================== helper
static func _get_instance() -> ConversationManager:
	return GameData.save_game.conversation_manager
