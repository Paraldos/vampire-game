extends Resource
class_name ConversationManager

const CONVERSATION_WINDOW = preload("uid://cyebgor0m0ncj")

# ======================================== set / get
static var current_conversation : Conversation:
	get:
		return GameData.save_game_current_conversation
	set(value):
		GameData.save_game._current_conversation = value

static var saved_conversations: Array[Conversation]:
	get:
		return GameData.save_game._saved_conversations
	set(value):
		GameData.save_game._saved_conversations = value

# ======================================== start / stop
static func start_conversation(new_conversation: Conversation) -> void:
	var saved_conversation := get_known_conversation(new_conversation)
	if saved_conversation:
		current_conversation = saved_conversation
		current_conversation.current_output = current_conversation.greeting
	else:
		current_conversation = new_conversation.duplicate(true)
		current_conversation.init()
		saved_conversations.append(current_conversation)
	SceneManager.push_overlay_scene(CONVERSATION_WINDOW)

static func end_conversation() -> void:
	current_conversation = null
	SceneManager.pop_overlay_scene()

# ======================================== submit
static func submit_keyword(key: String) -> void:
	var topic = current_conversation.get_topic_by_key(key)
	if topic:
		current_conversation.current_output = topic.output
		current_conversation.add_key_to_used(topic.key)
		current_conversation.check_text_for_keys()
	else:
		current_conversation.current_output = "I don't know anything about that."

# ======================================== helper
static func get_known_conversation(new_conversation: Conversation) -> Conversation:
	for conversation in saved_conversations:
		if conversation.get_id() == new_conversation.get_id():
			return conversation
	return null

static func get_suggested_keys():
	return current_conversation.suggested_keys

static func get_used_keys():
	return current_conversation.used_keys

static func get_known_keys() -> Array[String]:
	return current_conversation.suggested_keys	+ current_conversation.used_keys

static func get_character_name() -> String:
	return current_conversation.character_name

static func get_current_output() -> String:
	return current_conversation.current_output
