extends Node
# Global Signals

signal disable_action_btns
signal enable_action_btns
signal update_combat_stats
signal combat_action_focused(action: CombatAction)

signal update_conversation

signal display_animation(targets_player: bool, animation: Enums.ANIMATIONS, duration: float)
signal trigger_spawn_point(idx: int)
signal spawn_player(pos: Vector2)
