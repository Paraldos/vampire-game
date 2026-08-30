extends Node
# Global Signals

signal activate_character(activted_character : Character)
signal action_selected(selected_action: CombatAction)
signal action_cancelled
signal action_used(used_action: CombatAction, target: Character)
