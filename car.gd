extends CharacterBody2D

var wheel_base = 70  # Distance from front to rear wheel
var steering_angle = 45  # Amount that front wheel turns, in degrees

var steer_direction

var engine_power = 900  # Forward acceleration force.

var acceleration = Vector2.ZERO


var slip_speed = 400  # Speed where traction is reduced
var traction_fast = 2.5 # High-speed traction
var traction_slow = 10  # Low-speed traction

var canDrive = false

@onready var collision_shape_2d = $CollisionShape2D
@onready var timer = $Timer

@onready var countdown = $"../countdown"
@onready var countdown_timer = $"../countdownTimer"



func _physics_process(delta):
	countdown.text = str(countdown_timer.time_left)
	acceleration = Vector2.ZERO
	if canDrive == true:
		get_input(global.z)
		calculate_steering(delta)
		velocity += acceleration * delta
		move_and_slide()

func get_input(z):
	var turn = Input.get_axis("move_left", "move_right")
	steer_direction = turn * deg_to_rad(steering_angle)
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_shift"):
		velocity = transform.x * z

func calculate_steering(delta):
	# 1. Find the wheel positions
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	# 2. Move the wheels forward
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	# 3. Find the new direction vector
	var new_heading = rear_wheel.direction_to(front_wheel)
	# 4. Set the velocity and rotation to the new direction
	velocity = new_heading * velocity.length()
	rotation = new_heading.angle()
	
@onready var tiger_car_area = $"../flashtigercar/Path2D/PathFollow2D/tigerCarArea"

var tigercar_in_range = false
var boost_in_range = false


func _on_car_area_body_entered(body):
	if body.has_method("tigercar"):
		tigercar_in_range = true
	if body.has_method("boost"):
		boost_in_range = true


func _on_timer_timeout():
	canDrive = true
	countdown.visible = false
