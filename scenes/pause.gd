extends Control

var slider
var bus_index: int

func _ready():
	slider = $ColorRect/VBoxContainer/Volume
	bus_index = AudioServer.get_bus_index("Master")
	slider.value_changed.connect(_on_value_changed)

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_resume_pressed():
	hide()
	get_tree().paused = false
