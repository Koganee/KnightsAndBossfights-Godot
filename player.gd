extends CharacterBody2D

@onready var timer = $Timer

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const SPEED_MULTIPLIER = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_dashing = false
var time = 0.6

var dialogue_started = false
var bobot = load("res://scenes//bobot.tscn//$CollisionShapeBobot")

@onready var ray_cast_dialogue = $RayCastDialogue
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_dialogue = $detection_area/CollisionDialogue
@onready var collision_shape_bobot = $CollisionShapeBobot


func _physics_process(delta):
	
	
	if bobot_in_range == true:
		if Input.is_action_just_pressed("interact"):
			#bobot.set_deferred("disabled", true)
			dialogue_started = true
			DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "start")
			
	if king_in_range == true:
		if Input.is_action_just_pressed("interact"):
			#bobot.set_deferred("disabled", true)
			dialogue_started = true
			DialogueManager.show_example_dialogue_balloon(load("res://king.dialogue"), "start")
	
	if velius_in_range == true:
		if Input.is_action_just_pressed("interact"):
			#bobot.set_deferred("disabled", true)
			dialogue_started = true
			DialogueManager.show_example_dialogue_balloon(load("res://velius.dialogue"), "start")		
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	var current_speed = SPEED
	
	if Input.is_action_just_pressed("ui_shift"):
		is_dashing = true
		timer.start()
		
	if is_dashing:
		current_speed *= SPEED_MULTIPLIER
		
		
	if (time == 0):
		current_speed = SPEED	
			
		
			
		
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)



	
		
	move_and_slide()

	




func _on_timer_timeout():
	is_dashing = false

var bobot_in_range = false
var king_in_range = false
var velius_in_range = false





func _on_detection_area_body_entered(body):
	if body.has_method("bobot"):
		bobot_in_range = true
	if body.has_method("king"):
		king_in_range = true
	if body.has_method("velius"):
		velius_in_range = true	


func _on_detection_area_body_exited(body):
	if body.has_method("bobot"):
		bobot_in_range = false
	if body.has_method("king"):
		king_in_range = false
	if body.has_method("velius"):
		velius_in_range = false
