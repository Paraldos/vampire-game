extends Resource
class_name ConversationManager

const CONVERSATION_WINDOW = preload("uid://cyebgor0m0ncj")

# ======================================== set / get
static var conversation : Conversation:
	get:
		return Utils.game_data.conversation
	set(value):
		Utils.game_data.conversation = value

static var saved_conversations: Array[Conversation]:
	get:
		return Utils.game_data.saved_conversations
	set(value):
		Utils.game_data._saved_conversations = value

# ======================================== start / stop
static func start_conversation(new_conversation: Conversation) -> void:
	var saved_conversation := get_known_conversation(new_conversation)
	if saved_conversation:
		conversation = saved_conversation
		conversation.current_output = conversation.greeting
	else:
		conversation = new_conversation.duplicate(true)
		conversation.init()
		saved_conversations.append(conversation)
	SceneManager.push_overlay_scene(CONVERSATION_WINDOW)

static func end_conversation() -> void:
	conversation = null
	SceneManager.pop_overlay_scene()

# ======================================== submit
static func submit_keyword(key: String) -> void:
	if Utils.normalize_txt(key) == "escape" or Utils.normalize_txt(key) == "exit":
		end_conversation()
		return
	var topic = get_topic_by_key(key)
	if not topic or !topic.requirement_met():
		conversation.change_output("I don't know anything about that.")
	else:
		conversation.change_output(topic.output)
		topic.used = true
		topic.suggested = true
		topic.use_actions()
	GlobalSignals.update_conversation.emit()

static func get_topic_by_key(key: String) -> ConversationTopic:
	for topic in conversation.topics:
		if Utils.normalize_txt(topic.key) == Utils.normalize_txt(key):
			return topic
	return null

# ======================================== helper
static func get_known_conversation(new_conversation: Conversation) -> Conversation:
	for c in saved_conversations:
		if c.get_id() == new_conversation.get_id():
			return c
	return null

static func get_suggested_keys()-> Array[String]:
	return conversation.get_suggested_keys()

static func get_used_keys()-> Array[String]:
	return conversation.get_used_keys()

static func get_known_keys() -> Array[String]:
	return get_suggested_keys() + get_used_keys()

static func get_character_name() -> String:
	return conversation.character_name

static func get_current_output() -> String:
	return conversation.current_output
