extends Node

const harvest_speed = 5
var can_harvest

# For resource harvesting
@onready var tree_timer = $HarvestTimer
@onready var pb = $ProgressBar # Experiment with TextureProgressBar later
@onready var temp_instructions = $RemoveLater
@onready var sprite = $Sprite2D

# For harvesting other resources
var tree_texture = preload("res://imports/tree.png")
var rock_texture = preload("res://imports/rock.webp")
var random_type
var resource_amount
var random = RandomNumberGenerator.new()
var types = ["Rock", "Stick"]# Array can't be file locations as preload() requires a constant string

func _ready():
	pb.visible = false
	temp_instructions.visible = false
	# Resources each have a random value
	resource_amount = random.randi_range(1, 5)
	
	# Gets a random string from types array
	var size = types.size()
	random_type = types[randi() % size]
	match random_type:
		"Rock":
			sprite.texture = rock_texture
		"Stick":
			sprite.texture = tree_texture

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
	match random_type:
		"Rock":
			Globals.rock_count+=1
		"Stick":
			Globals.stick_count+=1
