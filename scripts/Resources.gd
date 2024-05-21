extends Sprite2D

var random = RandomNumberGenerator.new()
var resource_amount

func _ready():
	resource_amount = random.randi_range(1, 5)
	
func _on_area_2d_body_entered(body):
	match name:
		"Rock":
			Globals.rock_count+=resource_amount
		"Stick":
			Globals.stick_count+=resource_amount
	queue_free()
