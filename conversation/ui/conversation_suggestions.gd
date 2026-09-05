extends RichTextLabel

var start_phrase = "Topics: "
var used_color = "202e37"

func _ready() -> void:
	GlobalSignals.update_conversation.connect(_update)
	_update()

func _update() -> void:
	if ConversationManager.get_known_keys().is_empty():
		visible = false
		return
	text = start_phrase
	visible = true
	if !ConversationManager.get_suggested_keys().is_empty():
		text += ", ".join(ConversationManager.get_suggested_keys())
	if !ConversationManager.get_used_keys().is_empty():
		if text != start_phrase:
			text += ", "
		text += "[color=#%s]" % used_color
		text += ", ".join(ConversationManager.get_used_keys())
		text += "[/color]"
