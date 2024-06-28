extends CharacterBody2D

var speed = 40
var animal_flee = false   
var player = null

func _physics_process(delta):
	if animal_flee:
		
		position-= (player.position - position)/speed
		
		


func _on_npc_roam_area_body_entered(body):
	player = body
	animal_flee = true


func _on_npc_roam_area_body_exited(body):
	player = null
	animal_flee = false

func animal_despawn():
	queue_free()
