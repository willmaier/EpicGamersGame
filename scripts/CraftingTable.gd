extends Sprite2D

var is_crafting: bool = false
var player_present: bool = false


func _process(_delta):
	if (Input.is_action_just_pressed("interact") and player_present):
		print("start crafting")
		$"../HUD/Crafting_UI".visible = true
		#is_crafting = true

	if (Input.is_action_just_pressed("interact") and player_present):
		$"../HUD/Crafting_UI".visible = false
		#is_crafting = false
		
func _on_area_2d_body_entered(_body):
	player_present = true
	print("player is here")

func _on_area_2d_body_exited(body):
	player_present = false
	#$"../HUD/Crafting_UI".visible = false
	is_crafting = false
	

