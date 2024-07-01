extends MarginContainer

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
