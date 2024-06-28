extends Node2D

@export var bridge: Sprite2D
@export var missing_bridge: CollisionShape2D
var crash_sound
var bridge_broken = false
var bridge_break

var rock_inventory = load("res://prefabs/Inventory/Items/Rock.tres")
var stick_inventory = load("res://prefabs/Inventory/Items/Stick.tres")
var beehive_inventory = preload("res://prefabs/Inventory/Items/Beehive.tres")
var gem_inventory = preload("res://prefabs/Inventory/Items/Gem.tres")
var inventory = preload("res://prefabs/Inventory/Player_Inv.tres")

# Planting new trees
@export var tree_node: PackedScene
@onready var player = $Player


func _ready():
	missing_bridge = $MissingBridge/CollisionShape2D
	crash_sound = $MissingBridge/CrashSound
	bridge_break = $BridgeBreak

func _process(_delta):
	if (Globals.is_playing):
		$Music/StartingTrack.volume_db = -80
		$StartingTrack.volume_db = -80
		
	if (Globals.structure_count == 1): 
		$Music/StartingTrack.volume_db = -80
		$Music/SecondTrack.volume_db = 0


func _on_bridge_break_body_entered(_body):
	if (_body.name == "Player"):
		if (!bridge_broken):
			print("bridge broken")
			bridge.visible = false
			missing_bridge.set_deferred("disabled", false)
			#play sound effect
			crash_sound.play()
			bridge_broken = true
			bridge_break.queue_free()

func rebuild_bridge():
	if bridge_broken: 
		print("bridge fixed")
		bridge.visible = true
		missing_bridge.set_deferred("disabled", true)

func _on_tutorial_area_body_entered(_body):
	$TutorialArea/Intro.visible = true

func _on_tutorial_area_body_exited(_body):
	$TutorialArea/Intro.visible = false

func _on_cheat_button_pressed():
	inventory.add_item(stick_inventory.item_path,50)
	inventory.add_item(rock_inventory.item_path,50)
	inventory.add_item(beehive_inventory.item_path,50)
	inventory.add_item(gem_inventory.item_path,50)
	Globals.stick_count += 50
	Globals.rock_count += 50


func _on_player_plant_tree():
	if(Globals.can_plant == true):
		var tree = tree_node.instantiate()
		tree.position = player.position
		tree.get_node("Dirt").visible = true
		add_child(tree)
		Globals.can_plant = false
	else:
		print("Can't plant")
