extends Node
# Global Signals

# combat
signal disable_action_btns
signal enable_action_btns
signal update_combat_stats
signal combat_action_focused(action: CombatAction)

# conversation
signal update_conversation

# general
signal display_animation(targets_player: bool, animation: Enums.ANIMATIONS, duration: float)

# exploration
signal trigger_spawn_point(idx: int)
signal spawn_player(pos: Vector2)
signal map_created(map_rect: Rect2i)
signal reveal_cells(cells: Array[Vector2i])
