extends Area2D



func _on_body_entered(body):
	global.lapCount += 1
	if(global.lapCount == 4):
		print("Game Over")
	else:
		print(global.lapCount)	
		
		

