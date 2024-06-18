extends CharacterBody2D

const speed = 300.0

# Player tree animation
@onready var animated_sprite = $AnimationPlayer
@onready var animated_tree = $AnimationTree
@onready var state_machine = animated_tree.get("parameters/playback")

# Sound handling
@onready var player_walk_sound = $PlayerWalkSound

# Crafting
@onready var crafting_UI = $"../HUD/Crafting_UI"
@export var crafting_table: StaticBody2D
var is_crafting: bool = false

#@export var inv: Inv

# TODO if delta is use just remove the _
func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration
	# TODO this could use some optimization as it is simply just a placeholder
	# also there is a snapback issue with animation currently that can be fixed later
	#var horizontal_direction = Input.get_axis("move_left", "move_right")
	#var vertical_direction = Input.get_axis("move_up", "move_down")
	#if horizontal_direction || vertical_direction:
		#velocity.x = horizontal_direction * speed
		#velocity.y = vertical_direction * speed
	#else:
		#velocity.x = move_toward(velocity.normalized().x, 0, speed)
		#velocity.y = move_toward(velocity.normalized().y, 0, speed)
		#player_walk_sound.play()
	
	var input_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	set_animation(input_direction)
	velocity = input_direction * speed
	
	if input_direction == Vector2.ZERO:
		player_walk_sound.play()
	
	if (crafting_table.player_present and Input.is_action_just_pressed("interact")):
		toggle_crafting()

	
	move_and_slide()
	pick_new_state()

# TODO Use this when more states are added into the animation tree if we decide to use it
func set_animation(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animated_tree.set("parameters/walking/blend_position", move_input)
		animated_tree.set("parameters/idle/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walking")
	else:
		state_machine.travel("idle")

# Gives player access to the inventory
#func collect(item):
#	inv.insert(item)

func toggle_crafting():
	print("toggled crafting")
	#crafting_UI.visible = !crafting_UI.visible
	Globals.is_crafting = !Globals.is_crafting
