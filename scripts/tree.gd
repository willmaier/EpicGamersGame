extends Node

const harvest_speed = 5
var can_harvest

# For resource harvesting
@onready var tree_timer = $HarvestTimer
@onready var pb = $ProgressBar # Experiment with TextureProgressBar later
@onready var temp_instructions = $RemoveLater

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	try_harvesting()

func try_harvesting():
	pb.value = tree_timer.time_left * 20
	if Input.is_action_just_pressed("interact") && can_harvest: 
		tree_timer.start()
	elif Input.is_action_just_released("Harvest") || !can_harvest:
		tree_timer.stop() 
	

func _on_tree_area_body_entered(body):
	print("entered harvest area")
	pb.visible = true
	temp_instructions.visible = true
	can_harvest = true

func _on_tree_area_body_exited(body):
	print("exited harvest area")
	pb.visible = false
	temp_instructions.visible = false
	can_harvest = false

# Restart timer each harvest amd add to globals
func _on_harvest_timer_timeout():
	print("harvested")
	tree_timer.wait_time = harvest_speed 
	Globals.stick_count+=1
