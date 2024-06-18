extends MarginContainer

var spawner
var click_area: CollisionShape2D
var dead_area: CollisionShape2D
var timer: Timer
@onready var sub_viewport_container = $"../.."

@export var button = preload("res://prefabs/RhythmGame/rhythm_button.tscn")

@onready var harvest_timer = $"../../../HarvestTimer"

func _ready():
	spawner = $VBoxContainer/NinePatchRect/GameBar/ButtonSpawner
	click_area = $VBoxContainer/NinePatchRect/GameBar/ClickArea/ClickArea2D/CollisionShape2D
	dead_area = $VBoxContainer/NinePatchRect/GameBar/DeadArea/DeadArea2D/CollisionShape2D
	timer = $SpawnTimer
	#timer.start()

func _on_spawn_timer_timeout():
	var instance = button.instantiate()
	spawner.add_child(instance)
	timer.start()

func _on_click_area_2d_area_entered(area):
	area.get_parent().isPressable = true

func _on_click_area_2d_area_exited(area):
	area.get_parent().isPressable = false

func _on_dead_area_2d_area_entered(area):
	#sub_viewport_container.visible = false
	harvest_timer.stop()
	harvest_timer.start()
	area.get_parent().queue_free()


func _on_tree_area_body_entered(body):
	if body.name == "Player":
		sub_viewport_container.visible = true
		timer.start()


func _on_tree_area_body_exited(body):
	if body.name == "Player":
		sub_viewport_container.visible = false
		timer.stop()


func _on_harvest_timer_timeout():
	sub_viewport_container.visible = false
	timer.stop()
