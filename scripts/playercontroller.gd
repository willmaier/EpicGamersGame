extends CharacterBody2D

const SPEED = 300.0

@onready var animated_sprite = $AnimationPlayer
@onready var animated_tree = $AnimationTree

# if delta is use just remove the _
func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# TODO this could use some optimization as it is simply just a placeholder
	# also there is a snapback issue with animation currently that can be fixed later
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	var vertical_direction = Input.get_axis("move_up", "move_down")
	if horizontal_direction || vertical_direction:
		velocity.x = horizontal_direction * SPEED
		velocity.y = vertical_direction * SPEED
	else:
		velocity.x = move_toward(velocity.normalized().x, 0, SPEED)
		velocity.y = move_toward(velocity.normalized().y, 0, SPEED)
		
	set_animation()
	move_and_slide()

# Use this when more states are added into the animation tree if we decide to use it
func set_animation():
	animated_tree.set("parameters/walking/blend_position", velocity)
	

