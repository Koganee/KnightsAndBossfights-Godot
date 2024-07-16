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
#var bobot = load("res://scenes//bobot.tscn//$CollisionShapeBobot")
@onready var player = $"."
@onready var ray_cast_dialogue = $RayCastDialogue
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_dialogue = $detection_area/CollisionDialogue
@onready var collision_shape_bobot = $CollisionShapeBobot
const PLAYER_BUBBLE = preload("res://assets/sprites/PlayerBubble.png")
@onready var collision_shape_2d = $CollisionShape2D
@onready var playerSprite = $AnimatedSprite2D

const loading_scene_path = "res://scenes//candy_kingdom.tscn"

func _physics_process(delta):
	if $RayCastDialogue.is_colliding():
			if global.hasShard == true:
				if Input.is_action_just_pressed("interact"):
					get_tree().change_scene_to_file(loading_scene_path)
			
			
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
			await DialogueManager.show_example_dialogue_balloon(load("res://velius.dialogue"), "start")
			#if global.dialogue_started_switch_scene == false:
			#	get_tree().change_scene_to_file(loading_scene_path)		
	
	if bubble_in_range == true:
		velocity.y = JUMP_VELOCITY
		if Input.is_action_just_pressed("jump"):
			bubble_in_range = false
	
	if chocBot_in_range == true:
		if Input.is_action_just_pressed("interact"):
			await DialogueManager.show_example_dialogue_balloon(load("res://bobotChocolate.dialogue"), "start")
	if bubbleSeller_in_range == true:
		if Input.is_action_just_pressed("interact"):
			await DialogueManager.show_example_dialogue_balloon(load("res://bubbleSeller.dialogue"), "start")
	
	if enterCastle_in_range == true:
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file(loading_scene_path)
	
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
	elif bubble_in_range == true:
		animated_sprite.play("bubbleJump")		
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
var portal_in_range = false
var bubble_in_range = false
var chocBot_in_range = false
var bubbleSeller_in_range = false
var enterCastle_in_range = false

func _on_detection_area_body_entered(body):
	if body.has_method("bobot"):
		bobot_in_range = true
	if body.has_method("king"):
		king_in_range = true
	if body.has_method("velius"):
		velius_in_range = true	
	if body.has_method("portal"):
		portal_in_range = true	
	#if body.has_method("bubble"):
	#	bubble_in_range = true	
	#	print("Test!")
	if body.has_method("bobotChocolate"):
		chocBot_in_range = true	
		print("Test!")
	if body.has_method("bubbleSeller"):
		bubbleSeller_in_range = true	


func _on_detection_area_body_exited(body):
	if body.has_method("bobot"):
		bobot_in_range = false
	if body.has_method("king"):
		king_in_range = false
	if body.has_method("velius"):
		velius_in_range = false
	if body.has_method("portal"):
		portal_in_range = false	
	if body.has_method("bubble"):
		bubble_in_range = false	
	if body.has_method("bobotChocolate"):
		chocBot_in_range = false
	if body.has_method("bubbleSeller"):
		bubbleSeller_in_range = false			


func _on_bubble_body_entered(body):
	bubble_in_range = true	
	print("Test!")


func _on_enter_castle_body_entered(body):
	enterCastle_in_range = true
	print("Test!")
func _on_enter_castle_body_exited(body):
	enterCastle_in_range = false
