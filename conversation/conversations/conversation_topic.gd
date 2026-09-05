extends Resource
class_name ConversationTopic

@export var key := ""
@export_multiline var output := ""
@export var actions: Array[Action]

@export_storage var used := false
@export_storage var suggested := false

func requirement_met():
	for action in actions:
		if !action.requirement_met():
			return false
	return true

func use_actions():
	for action in actions:
		if action.requirement_met():
			action.use()
