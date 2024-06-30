extends Node


var has_enough: bool = false

func _process(delta):
	has_enough = Globals.has_enough
