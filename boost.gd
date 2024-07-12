extends Area2D

@onready var timer = $Timer


func boost():
	pass


func _on_body_entered(body):
	global.z = 600
	timer.start()
	
func _on_timer_timeout():
	global.z = 400		
