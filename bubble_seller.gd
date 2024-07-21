extends CharacterBody2D

func bubbleSeller():
	pass
	

func _process(delta):
	if global.readyToRhythm == true:
		get_tree().change_scene_to_file("res://scenes/rhythm_game.tscn")
		global.readyToRhythm = false
