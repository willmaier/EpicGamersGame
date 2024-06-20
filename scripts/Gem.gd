extends Node

@onready var sprite = $"."

func _on_area_2d_body_entered(body):
	if sprite.visible == true:
		get_tree().call_group("Resources","collect_gem")
