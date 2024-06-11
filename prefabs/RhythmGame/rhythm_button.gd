extends Sprite2D

var dir: String
var isPressable: bool = false
@export var speed: int = 3

func _ready():
	frame = randi_range(0, 3)
	if frame == 0:
		dir = "move_right"
	elif frame == 1:
		dir = "move_left"
	elif frame == 2:
		dir = "move_up"
	elif frame == 3:
		dir = "move_down"
	print(dir)

func _process(delta):
	position.x -= speed
	if (Input.is_action_just_pressed(dir) and isPressable):
		#create global variable to track how many are pressed for each minigame?
		queue_free()

