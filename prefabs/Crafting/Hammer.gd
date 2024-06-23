extends Button

var crafting_ui = get_parent()

# Called when the node enters the scene tree for the first time.
func _on_pressed():
	crafting_ui._on_hammer_pressed()
