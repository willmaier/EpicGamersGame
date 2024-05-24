extends CharacterBody2D

const speed = 300.0

# Player tree animation
@onready var animated_sprite = $AnimationPlayer
@onready var animated_tree = $AnimationTree

# Sound handling
@onready var player_walk_sound = $PlayerWalkSound

# Crafting
@onready var crafting_UI = $"../HUD/Crafting_UI"
@export var crafting_table: Sprite2D
var is_crafting: bool = false

@export var inv: Inv

# TODO if delta is use just remove the _
func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration
	# TODO this could use some optimization as it is simply just a placeholder
	# also there is a snapback issue with animation currently that can be fixed later
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	var vertical_direction = Input.get_axis("move_up", "move_down")
	if horizontal_direction || vertical_direction:
		velocity.x = horizontal_direction * speed
		velocity.y = vertical_direction * speed
	else:
		velocity.x = move_toward(velocity.normalized().x, 0, speed)
		velocity.y = move_toward(velocity.normalized().y, 0, speed)
		player_walk_sound.play()
	if (is_crafting and Input.is_action_just_pressed("interact")):
		crafting_UI.visible = false
		is_crafting = false
	if (crafting_table.player_present and Input.is_action_just_pressed("interact")):
		crafting_UI.visible = true
		is_crafting = true
	set_animation()
	move_and_slide()

# TODO Use this when more states are added into the animation tree if we decide to use it
func set_animation():
	animated_tree.set("parameters/walking/blend_position", velocity)
