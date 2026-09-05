extends Action
class_name FlagAction

@export var add: Array[Flag]
@export var remove: Array[Flag]
@export var required: Array[Flag]
@export var forbidden: Array[Flag]

func use() -> void:
	for flag in add:
		FlagsManager.add_flag(flag)
	for flag in remove:
		FlagsManager.remove_flag(flag)

func requirement_met() -> bool:
	for flag in forbidden:
		if FlagsManager.has_flag(flag):
			return false
	for flag in required:
		if not FlagsManager.has_flag(flag):
			return false
	return true
