extends CharacterBody2D

const speed = 300.0

signal plant_tree

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
	# When player is interacting movement is disabled
	
	if(!Input.is_action_pressed("interact") and Globals.is_playing == false):
		var input_direction = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		)
		set_animation(input_direction)
		velocity = input_direction * speed
		if (Globals.is_crafting == false):
				velocity = input_direction * speed
	# Player is pressing e
	else:
		velocity = Vector2.ZERO
	if (crafting_table.player_present and Input.is_action_just_pressed("interact") and !Globals.is_playing):
		toggle_crafting()
	if(Input.is_action_just_pressed("plant")):
		plant_tree.emit()
	move_and_slide()
	pick_new_state()

	if (velocity == Vector2.ZERO):
		player_walk_sound.play()

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
	player_walk_sound.stop()
	#crafting_UI.visible = !crafting_UI.visible
	Globals.is_crafting = !Globals.is_crafting


func _on_tutorial_area_body_entered(body):
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "start1")

# TODO behavior when player leaves
func _on_tutorial_area_body_exited(body):
	pass
