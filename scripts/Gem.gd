extends Node

@onready var sprite = $"."

func _on_area_2d_body_entered(body):
	#print(body)
	#if body.name == "Player":
		#queue_free()
	if sprite.visible == true:
		get_tree().call_group("Resources","collect_gem")
		
		
func remove_gem():
	sprite.visible = false
