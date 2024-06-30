extends Node


var has_enough: bool = false
var finished: bool = false

func _process(delta):
	has_enough = Globals.has_enough
	Globals.finished = finished
