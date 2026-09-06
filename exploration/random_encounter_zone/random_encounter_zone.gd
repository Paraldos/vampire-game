extends Area2D
class_name RandomEncounterZone

@export var encounter_chance := 7
@export var possible_encounters: Array[Enemy]

func _ready() -> void:
	if possible_encounters.is_empty():
		push_warning('Randome Encounter Zone has no valid enemies.')
		queue_free()

func try_trigger_encounter() -> void:
	if Utils.roll_dice(100) > encounter_chance:
		return
	var selected_enemy = possible_encounters.pick_random()
	CombatManager.start_combat(selected_enemy)
