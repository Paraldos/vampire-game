extends Node

signal change_dialog(new_dialog)
signal end_dialog
signal spawn_player(target_point)

signal left_clicked_floor(cell : Vector2i)
signal left_click_enemy(enemy : CharacterTemplate)
signal shift_click(target_pos : Vector2)
signal chase_attack(target_pos : Vector2)

signal update_inventory
