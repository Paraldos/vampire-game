extends Resource
class_name ConversationTopic

@export var key := ""
@export_multiline var output := ""
@export var actions: Array[Action]

func use_actions():
	for action in actions:
		if action.requirement_met():
			action.use()
