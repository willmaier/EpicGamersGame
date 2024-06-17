extends Node

# For resource harvesting
@onready var tree_timer = $HarvestTimer
@onready var harvest_cooldown = $HarvestCooldown
@onready var pb = $ProgressBar # Experiment with TextureProgressBar later
@onready var temp_instructions = $RemoveLater
@onready var sprite = $Sprite2D
const harvest_speed = 5
var can_harvest
var off_cooldown : bool = true

# For harvesting other resources
var tree_texture = preload("res://imports/tree.png")
var rock_texture = preload("res://imports/rock.webp")

# For adding images to inventory
var rock_inventory = load("res://prefabs/Inventory/Items/Rock.tres")
var stick_inventory = load("res://prefabs/Inventory/Items/Stick.tres")
var inventory = preload("res://prefabs/Inventory/Player_Inv.tres")


# TODO add new resources to this
@export_enum("Stick", "Rock", "Random") var _type: String
var types = ["Rock", "Stick"]# Array can't be file locations as preload() requires a constant string
var resource_amount = 1
var random = RandomNumberGenerator.new()

func _ready():
	pb.visible = false
	temp_instructions.visible = false
	# Resources each have a random value
	resource_amount = random.randi_range(1, 5)
	
	# Gets a random string from types array
	var size = types.size()
	# User did not enter type in inspector
	if _type == "Random":
		_type = types[randi() % size]
	match _type:
		"Rock":
			sprite.texture = rock_texture
		"Stick":
			sprite.texture = tree_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if off_cooldown:
		try_harvesting()
		temp_instructions.text = "Hold E for 5 seconds"
	else:
		tree_timer.stop() 
		# For larger cooldown times
		# "%d:%02d" % [floor(harvest_cooldown.time_left / 60), int(harvest_cooldown.time_left) % 60]
		temp_instructions.text = "Can't harvest for" + "%2d seconds" % [int(harvest_cooldown.time_left) % 60]

func try_harvesting():
	pb.value = tree_timer.time_left * 20
	if Input.is_action_just_pressed("interact") && can_harvest: 
		tree_timer.start()
	elif Input.is_action_just_released("interact") || !can_harvest:
		tree_timer.stop() 

func _on_tree_area_body_entered(body):
	if body.name == "Player":
		#print("entered harvest area")
		pb.visible = true # Show progress bar
		can_harvest = true
		temp_instructions.visible = true # TODO Can remove or change these later

func _on_tree_area_body_exited(body):
	if body.name == "Player":
		#print("exited harvest area")
		pb.visible = false
		can_harvest = false
		temp_instructions.visible = false # TODO Can remove or change these later

# Restart timer each harvest and add to globals
func _on_harvest_timer_timeout():
	#print("harvested")
	
	# TODO add a visual cue so players know they can't harvest
	harvest_cooldown.start()
	off_cooldown = false
	
	# Restart harvesting timer
	tree_timer.wait_time = harvest_speed 
	
	# TODO there might be a better way to do this but this works for now
	match _type:
		"Rock":
			print("harvested Rock")
			Globals.rock_count+=resource_amount
			inventory.add_item(rock_inventory.item_path,1)
			inventory.print_inventory()
		"Stick":
			print("harvested Stick")
			Globals.stick_count+=resource_amount
			inventory.add_item(stick_inventory.item_path,[1,2].pick_random())
			inventory.print_inventory()

# Players must wait to harvest again
func _on_harvest_cooldown_timeout():
	off_cooldown = true
