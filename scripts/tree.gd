extends Node

# For resource harvesting
@onready var tree_timer = $HarvestTimer
@onready var harvest_cooldown = $HarvestCooldown
@onready var pb = $ProgressBar # Experiment with TextureProgressBar later
@onready var temp_instructions = $RemoveLater
@onready var chop_sound = $TreeSound
@onready var mine_sound = $MiningSound

const harvest_speed = 5
var harvest_amount = 1
var can_harvest
var off_cooldown : bool = true

# For harvesting other resources
@onready var tree_node = $Tree
@onready  var rock_node = $Rock
@onready var beehive = $Beehive
@onready var dirt = $Dirt
@onready var gem = $Gem

var has_hive = false
var has_gem = true


# For adding images to inventory
var rock_inventory = load("res://prefabs/Inventory/Items/Rock.tres")
var stick_inventory = load("res://prefabs/Inventory/Items/Stick.tres")
var beehive_inventory = preload("res://prefabs/Inventory/Items/Beehive.tres")
var gem_inventory = preload("res://prefabs/Inventory/Items/Gem.tres")
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
	display(_type)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if off_cooldown:
		try_harvesting()
		temp_instructions.text = "Hold E for 5 seconds"
	else:
		tree_timer.stop() 
		tree_node.visible = false
		beehive.visible = false
		if _type == "Rock" and gem != null and has_gem:
			rock_node.visible = false
			gem.visible = true
		# For larger cooldown times
		# "%d:%02d" % [floor(harvest_cooldown.time_left / 60), int(harvest_cooldown.time_left) % 60]
		
		if(int(harvest_cooldown.time_left < 1)) and _type != "Rock":
			temp_instructions.text = "Try watering (Press e)"
			if Input.is_action_just_pressed("interact"):
				try_watering()
		else:
			temp_instructions.text = "Can't harvest for " + "%2d seconds" % [int(harvest_cooldown.time_left) % 60]
			try_watering()

func try_harvesting():
	tree_timer.wait_time = Globals.harvest_speed
	pb.value = tree_timer.time_left * (100/Globals.harvest_speed)
	if Input.is_action_just_pressed("interact") && can_harvest: 
		tree_timer.start()
		if (_type == "Stick"):
			chop_sound.play()
		if (_type == "Rock"):
			mine_sound.play()
	elif Input.is_action_just_released("interact") || !can_harvest:
		tree_timer.stop()
		chop_sound.stop()
		mine_sound.stop() 

func _on_tree_area_body_entered(body):
	if body.name == "Player":
		if Globals.first_interact:
			Globals.first_interact = false
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "farm")
			await DialogueManager.dialogue_ended
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
	chop_sound.stop()
	mine_sound.stop()
	#print("harvested")
	
	# TODO add a visual cue so players know they can't harvest
	#harvest_cooldown.start()
	off_cooldown = false
	
	# Restart harvesting timer
	tree_timer.wait_time = Globals.harvest_speed
	
	if (Globals.pickaxe_tool == true):
		harvest_amount = 5
	# TODO there might be a better way to do this but this works for now
	match _type:
		"Rock":
			print("harvested Rock")
			Globals.rock_count+=resource_amount
			inventory.add_item(rock_inventory.item_path,harvest_amount)
			inventory.print_inventory()
			# TODO need to change this behavior
			Globals.has_enough = true
			
		"Stick":
			print("harvested Stick")
			Globals.stick_count+=resource_amount
			inventory.add_item(stick_inventory.item_path,harvest_amount)
			inventory.print_inventory()
			# TODO need to change this behavior
			Globals.can_plant = true 
			# TODO Works but image needs to be smaller
			if has_hive:
				print("harvested hive")
				inventory.add_item(beehive_inventory.item_path,1)

# Players must wait to harvest again
func _on_harvest_cooldown_timeout():
	off_cooldown = true
	display(_type)
	
func display(_type):
	match _type:
		"Rock":
			rock_node.visible = true
		"Stick":
			tree_node.visible = true
			dirt.visible = true
			# For beehives in trees
			if random.randi() % 2:
				has_hive = true
				beehive.visible = true

func collect_gem():
	if gem.visible == true:
		has_gem = false
		gem.visible = false
		inventory.add_item(gem_inventory.item_path,1)
		
func try_watering():
	if(harvest_cooldown.is_stopped()):
		print("watering")
		harvest_cooldown.start()
	
