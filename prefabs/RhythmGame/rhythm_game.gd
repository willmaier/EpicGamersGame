extends MarginContainer

var spawner
var click_area: CollisionShape2D
var dead_area: CollisionShape2D
var timer: Timer

@export var button = preload("res://prefabs/RhythmGame/rhythm_button.tscn")

func _ready():
	spawner = $VBoxContainer/NinePatchRect/GameBar/ButtonSpawner
	click_area = $VBoxContainer/NinePatchRect/GameBar/ClickArea/ClickArea2D/CollisionShape2D
	dead_area = $VBoxContainer/NinePatchRect/GameBar/DeadArea/DeadArea2D/CollisionShape2D
	timer = $SpawnTimer
	timer.start()

func _on_spawn_timer_timeout():
	var instance = button.instantiate()
	spawner.add_child(instance)
	timer.start()

func _on_click_area_2d_area_entered(area):
	area.get_parent().isPressable = true

func _on_click_area_2d_area_exited(area):
	area.get_parent().isPressable = false

func _on_dead_area_2d_area_entered(area):
	area.get_parent().queue_free()
