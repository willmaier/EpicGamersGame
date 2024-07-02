extends CharacterBody2D

var speed = 40
var animal_flee = false   
var player = null
@export var anim_player: AnimationPlayer

func _physics_process(delta):
	if animal_flee:
		
		position-= (player.position - position)/speed
		
		if (velocity.x < 0 ):
			anim_player.play("beaver_left")
		elif (velocity.x < velocity.y and velocity.y < 0):
			anim_player.play("beaver_up")
		elif (velocity.x > 0 and velocity.y < velocity.x):
			anim_player.play("beaver_right")
		else:
			pass
			#anim_player.play("beaver_down")


func _on_area_2d_body_entered(body):
	player = body
	animal_flee = true


func _on_area_2d_body_exited(body):
	player = null
	animal_flee = false

func animal_despawn():
	queue_free()
