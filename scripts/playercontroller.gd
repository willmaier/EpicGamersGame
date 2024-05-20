extends CharacterBody2D

const SPEED = 300.0

@onready var animated_sprite = $AnimationPlayer
@onready var animated_tree = $AnimationTree

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_direction = Input.get_axis("ui_left", "ui_right")
	var vertical_direction = Input.get_axis("ui_up", "ui_down")
	if horizontal_direction:
		velocity.x = horizontal_direction * SPEED
	if vertical_direction:
		velocity.y = vertical_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	check_animation_orientation()
	move_and_slide()

func check_animation_orientation():
	animated_tree.set("parameters/walking/blend_position", velocity)
