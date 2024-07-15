extends Control

const loading_scene_path = "res://scenes//kingdom_of_sweets.tscn"

func _on_button_pressed():
	get_tree().change_scene_to_file(loading_scene_path)
