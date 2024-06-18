extends Control

@export var mat1: HBoxContainer
@export var mat2: HBoxContainer
@export var tool1: HBoxContainer
@export var tool2: HBoxContainer

func _process(_delta):
	if Globals.is_crafting:
		visible = true
	else:
		visible = false

func _on_tool_1_button_pressed():
	if (Globals.stick_count >= 2 && Globals.rock_count >= 1):
		Globals.stick_count -= 2
		Globals.rock_count -= 1
		Globals.hammer_tool = true
		Globals.harvest_speed = 3
		tool1.queue_free()
		print("hammer made")

func _on_tool_2_button_pressed():
	if (Globals.stick_count >= 10 and Globals.rock_count >= 10):
		Globals.stick_count -= 10
		Globals.rock_count -= 10
		Globals.pickaxe_tool = true
		tool2.queue_free()
		print("Pickaxe made")
