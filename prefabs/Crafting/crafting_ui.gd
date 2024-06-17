extends Control

func _process(_delta):
	if Globals.is_crafting:
		visible = true
	else:
		visible = false


func _on_hammer_pressed():
	if (Globals.stick_count >= 2 && Globals.rock_count >= 1):
		Globals.stick_count -= 2
		Globals.rock_count -= 1
		Globals.hammer_count += 1
		print("hammer made")
