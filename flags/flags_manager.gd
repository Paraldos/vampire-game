extends Resource
class_name FlagsManager

# ======================================== set / get
static var flags: Array[Flag]:
	set(value):
		Utils.game_data.flags = value
	get:
		return Utils.game_data.flags

# ======================================== helper
static func has_flag(flag: Flag) -> bool:
	return flags.has(flag)

static func add_flag(flag: Flag) -> void:
	if flag == null or has_flag(flag):
		return
	flags.push_back(flag)

static func remove_flag(flag: Flag) -> void:
	if flag == null:
		return
	flags.erase(flag)