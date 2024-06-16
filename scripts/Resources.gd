extends Sprite2D

var random = RandomNumberGenerator.new()
var resource_amount
var random_type

# Array can't be file locations as preload() requires a constant string
var types = ["Rock", "Stick"]
var stick_texture = preload("res://imports/stick.bmp")
var rock_texture = preload("res://imports/rock.bmp")

var rock = preload("res://prefabs/Inventory/Items/Rock.tres")
var stick = preload("res://prefabs/Inventory/Items/Stick.tres")

var inventory = preload("res://prefabs/Inventory/Player_Inv.tres")

func _ready():
	# Resources each have a random value
	resource_amount = random.randi_range(1, 5)
	
	# Gets a random string from types array
	var size = types.size()
	random_type = types[randi() % size]
	match random_type:
		"Rock":
			texture = rock_texture
		"Stick":
			texture = stick_texture

# Add values to global and remove instance
func _on_area_2d_body_entered(_body):
	#print(random_type)
	match random_type:
		"Rock":
			Globals.rock_count+=resource_amount
			inventory.add_item(rock.item_path,1)
			inventory.print_inventory()
			
		"Stick":
			Globals.stick_count+=resource_amount
			inventory.add_item(stick.item_path,[1,2].pick_random())
			inventory.print_inventory()
	queue_free()
