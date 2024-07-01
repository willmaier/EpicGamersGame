extends StaticBody2D

var is_crafting: bool = false
var player_present: bool = false
var instructions: Label
@export_enum("Crafting") var _type: String

func _ready():
	instructions = $Instructions

func _process(_delta):
	if (Globals.is_crafting):
		instructions.visible = false

func _on_crafting_area_body_entered(body):
	if body.name == "Player":
		print("entered crafting area")
		player_present = true
		instructions.visible = true
		Globals.can_pause = false


func _on_crafting_area_body_exited(body):
	if body.name == "Player":
		print("exited crafting area")
		player_present = false
		instructions.visible = false
		Globals.is_crafting = false
		Globals.can_pause = true
