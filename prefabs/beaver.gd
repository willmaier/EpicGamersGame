extends CharacterBody2D

var speed: float = 100
var target_position: Vector2 = Vector2(1175, -990)
@export var player: CharacterBody2D
@onready var anim_player = $AnimationPlayer

@export var nav_agent: NavigationAgent2D

func _ready():
	nav_agent.path_desired_distance = 3.0
	nav_agent.target_desired_distance = 5.0
	
	call_deferred("actor_setup")

func _physics_process(_delta):
	if nav_agent.is_navigation_finished():
		return
	
	var current_position: Vector2 = global_position
	var next_position: Vector2 = nav_agent.get_next_path_position()
	
	velocity = current_position.direction_to(next_position) * speed
	set_animation(current_position.direction_to(next_position).normalized())
	move_and_slide()

func actor_setup():
	await get_tree().physics_frame
	set_movement_target(target_position)

func set_movement_target(movement_target: Vector2):
	nav_agent.target_position = movement_target

func set_animation(dir: Vector2):
	if (dir.x < 0 and dir.x < dir.y):
		anim_player.play("beaver_left")
	elif (dir.x < dir.y and dir.y < 0):
		anim_player.play("beaver_up")
	elif (dir.x > 0 and dir.y < dir.x):
		anim_player.play("beaver_right")
	else:
		anim_player.play("beaver_down")

func _on_timer_timeout():
	set_movement_target(player.global_position)
