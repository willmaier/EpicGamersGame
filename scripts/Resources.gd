extends Sprite2D

var random = RandomNumberGenerator.new()
var resource_amount
var types = ["Rock", "Stick"]
var random_type

var stick_texture = preload("res://imports/stick.bmp")
var rock_texture = preload("res://imports/rock.bmp")

func _ready():
	resource_amount = random.randi_range(1, 5)
	var size = types.size()
	random_type = types[randi() % size]
	match random_type:
		"Rock":
			texture = rock_texture
		"Stick":
			texture = stick_texture
			
			
func _on_area_2d_body_entered(body):
	#print(random_type)
	match random_type:
		"Rock":
			Globals.rock_count+=resource_amount
		"Stick":
			Globals.stick_count+=resource_amount
	queue_free()
