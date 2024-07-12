extends Node2D


@onready var path_follow_2d = $Path2D/PathFollow2D

var speed = 375

func _process(delta: float) -> void:
	path_follow_2d.progress += speed * delta

func tigercar():
	pass
