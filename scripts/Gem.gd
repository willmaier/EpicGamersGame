extends Node

func _on_area_2d_body_entered(body):
	print(body)
	if body.name == "Player":
		queue_free()
