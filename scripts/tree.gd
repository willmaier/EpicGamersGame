extends Node

const harvest_speed = 5
var can_harvest

# For resource harvesting
@onready var tree_timer = $HarvestTimer
@onready var pb = $ProgressBar # Experiment with TextureProgressBar later
@onready var temp_instructions = $RemoveLater
@onready var sprite = $Sprite2D

# For harvesting other resources
#var stick_texture = preload("res://imports/stick.bmp")
var rock_texture = preload("res://imports/rock.webp")

# Called when the node enters the scene tree for the first time.
func _ready():
	pb.visible = false
	temp_instructions.visible = false
	# Testing when harvesting other resources
	#if get_tree().get_root().name == "rock":
		#sprite.texture = rock_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	try_harvesting()

func try_harvesting():
	pb.value = tree_timer.time_left * 20
	if Input.is_action_just_pressed("interact") && can_harvest: 
		tree_timer.start()
	elif Input.is_action_just_released("interact") || !can_harvest:
		tree_timer.stop() 
	

func _on_tree_area_body_entered(body):
	if body.name == "Player":
		print("entered harvest area")
		pb.visible = true
		temp_instructions.visible = true
		can_harvest = true

func _on_tree_area_body_exited(body):
	if body.name == "Player":
		print("exited harvest area")
		pb.visible = false
		temp_instructions.visible = false
		can_harvest = false

# Restart timer each harvest amd add to globals
func _on_harvest_timer_timeout():
	print("harvested")
	tree_timer.wait_time = harvest_speed 
	Globals.stick_count+=1
