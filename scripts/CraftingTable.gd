extends Sprite2D

var is_crafting: bool = false
var player_present: bool = false

		
func _on_area_2d_body_entered(_body):
	player_present = true
	print("player is here")

func _on_area_2d_body_exited(_body):
	player_present = false
	$"../HUD/Crafting_UI".visible = false
	is_crafting = false
	

