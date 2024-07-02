extends MarginContainer

var spawner
var click_area: CollisionShape2D
var dead_area: CollisionShape2D
var timer: Timer
var intro_timer: Timer
var music: AudioStreamPlayer2D
var game_active: bool = false

@onready var sub_viewport_container = $"../.."
@export var button = preload("res://prefabs/RhythmGame/rhythm_button.tscn")
@onready var harvest_timer = $"../../../HarvestTimer"

func _ready():
	spawner = $VBoxContainer/NinePatchRect/GameBar/ButtonSpawner
	click_area = $VBoxContainer/NinePatchRect/GameBar/ClickArea/ClickArea2D/CollisionShape2D
	dead_area = $VBoxContainer/NinePatchRect/GameBar/DeadArea/DeadArea2D/CollisionShape2D
	timer = $SpawnTimer
	intro_timer = $IntroTimer
	music = $GameMusic

func game_start():
	intro_timer.start()
	music.play()
	game_active = true

func game_end():
	timer.stop()
	game_active = false

func _on_intro_timer_timeout():
	timer.start()

func _on_spawn_timer_timeout():
	if (game_active):
		timer.start()
		spawner.add_child(button.instantiate())
	

func _on_click_area_2d_area_entered(area):
	area.get_parent().isPressable = true

func _on_click_area_2d_area_exited(area):
	area.get_parent().isPressable = false

func _on_dead_area_2d_area_entered(area):
	#sub_viewport_container.visible = false
	#harvest_timer.stop()
	#harvest_timer.start()
	area.get_parent().queue_free()
	print("game over")




