extends Node2D

const AL = preload("res://scenes/move_arrow_left.tscn")
const AU = preload("res://scenes/move_arrow_up.tscn")
const AD = preload("res://scenes/move_arrow_down.tscn")
const AR = preload("res://scenes/move_right_arrow.tscn")

var random = 0
var RNG = RandomNumberGenerator.new()


func _process(delta):
	pass


func _on_timer_timeout():
	$Timer.start()
	RNG.randomize()
	var random_int = RNG.randi_range(0,4)
	random = random_int
	
	if random == 1:
		var al = AL.instantiate()
		get_parent().add_child(al)
		al.position = $Create/Marker2D_AL.global_position
		
	if random == 2:
		var au = AU.instantiate()
		get_parent().add_child(au)
		au.position = $Create/Marker2D_AU.global_position
	if random == 3:
		var ad = AD.instantiate()
		get_parent().add_child(ad)
		ad.position = $Create/Marker2D_AD.global_position
	if random == 4:
		var ar = AR.instantiate()
		get_parent().add_child(ar)
		ar.position = $Create/Marker2D_AR.global_position		
