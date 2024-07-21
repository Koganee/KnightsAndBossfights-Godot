extends Area2D

@onready var animation_player = $AnimationPlayer

var sensor = 0


func _process(delta):
	if sensor == 1:
		if Input.is_action_just_pressed("move_left"):
			animation_player.play("Good")
			global.rhythmScore += 1
	if sensor == 0:
		if Input.is_action_just_pressed("move_left"):
			animation_player.play("Bad")	
			global.rhythmLives -= 1
	
	


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = 1
	global.sensor_AL = 1

func _on_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = 0
	global.sensor_AL = 0
