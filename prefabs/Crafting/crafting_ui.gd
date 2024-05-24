extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_hammer_pressed():
	if (Globals.stick_count >= 2 && Globals.rock_count >= 1):
		Globals.stick_count -= 2
		Globals.rock_count -= 1
		Globals.hammer_count += 1
		print("hammer made")
