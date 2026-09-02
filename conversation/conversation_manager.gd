extends Resource
class_name ConversationManager

const CONVERSATION_WINDOW = preload("uid://cyebgor0m0ncj")

@export_storage var _current_conversation: Conversation
static var current_conversation : Conversation:
	get:
		return _get_instance()._current_conversation
	set(value):
		_get_instance()._current_conversation = value

@export_storage var _saved_conversations: Array[Conversation]
static var saved_conversations: Array[Conversation]:
	get:
		return _get_instance()._saved_conversations
	set(value):
		_get_instance()._saved_conversations = value

# ======================================== check for keyword
static func submit_keyword(normalized_submited_keyword: String) -> void:
	for topic in current_conversation.topics:
		if topic.get_normalized_key() == normalized_submited_keyword:
			current_conversation.current_output = topic.output
			return
	current_conversation.current_output = "I don't know anything about that."

# ======================================== start / stop
static func start_conversation(new_conversation: Conversation) -> void:
	var saved_conversation := get_known_conversation(new_conversation)
	if saved_conversation:
		current_conversation = saved_conversation
		current_conversation.current_output = current_conversation.greeting
	else:
		current_conversation = new_conversation
		current_conversation.init()
		saved_conversations.append(new_conversation)
	SceneManager.push_overlay_scene(CONVERSATION_WINDOW)

static func get_known_conversation(new_conversation: Conversation) -> Conversation:
	for conversation in saved_conversations:
		if conversation.get_id() == new_conversation.get_id():
			return conversation
	return null

static func end_conversation() -> void:
	current_conversation = null
	SceneManager.pop_overlay_scene()

# ======================================== helper
static func get_character_name() -> String:
	return current_conversation.character_name

static func get_current_output() -> String:
	return current_conversation.current_output

static func _get_instance() -> ConversationManager:
	return GameData.save_game.conversation_manager
