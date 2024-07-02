extends Control

# UI elements
@export var crafting_bg: Panel
@export var crafting_window: MarginContainer
@export var game_bg: ColorRect
@export var game_window: MarginContainer

# Crafting entries
@export var mat1: HBoxContainer
@export var mat2: HBoxContainer
@export var tool1: HBoxContainer
@export var tool2: HBoxContainer
@export var struct1: HBoxContainer
@export var struct2: HBoxContainer

@export var game_timer: Timer
@export var game2_timer: Timer

var inventory = preload("res://prefabs/Inventory/Player_Inv.tres")
var rock_inventory = load("res://prefabs/Inventory/Items/Rock.tres")
var stick_inventory = load("res://prefabs/Inventory/Items/Stick.tres")
var beehive_inventory = preload("res://prefabs/Inventory/Items/Beehive.tres")
var gem_inventory = preload("res://prefabs/Inventory/Items/Gem.tres")

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
		inventory.add_item(stick_inventory.item_path,-2)
		inventory.add_item(rock_inventory.item_path,-1)

func _on_tool_2_button_pressed():
	if (Globals.stick_count >= 10 and Globals.rock_count >= 10):
		Globals.stick_count -= 10
		Globals.rock_count -= 10
		inventory.add_item(stick_inventory.item_path,-10)
		inventory.add_item(rock_inventory.item_path,-10)
		Globals.pickaxe_tool = true
		tool2.queue_free()
		print("Pickaxe made")


func _on_structure_1_button_pressed():
	if (Globals.stick_count >= 25 and Globals.rock_count >= 25):
		Globals.stick_count -= 25
		Globals.rock_count -= 25
		inventory.add_item(stick_inventory.item_path,-25)
		inventory.add_item(rock_inventory.item_path,-25)
		crafting_bg.visible = false
		crafting_window.visible = false
		game_bg.visible = true
		game_window.visible = true
		game_window.game_start()
		game_timer.start()
		Globals.is_playing = true
		Globals.has_enough = true
		$"../../../..".rebuild_bridge()

func _on_structure_2_button_pressed():
	if (Globals.stick_count >= 25 and Globals.rock_count >= 25
	and Globals.honey_count >= 10 and Globals.gem_count >= 10
	):
		print("play dam game")
		Globals.stick_count -= 25
		Globals.rock_count -= 25
		Globals.honey_count -= 10
		Globals.gem_count -= 10
		crafting_bg.visible = false
		crafting_window.visible = false
		game_bg.visible = true
		game_window.visible = true
		game_window.game_start()
		game2_timer.start()
		Globals.is_playing = true
		$"../../../..".build_dam()

func _on_game_timer_timeout():
		print("game timer over")
		game_window.game_end()
		crafting_bg.visible = true
		crafting_window.visible = true
		game_bg.visible = false
		game_window.visible = false
		struct1.queue_free()
		Globals.is_playing = false
		Globals.structure_count += 1
		Globals.has_enough = true

func _on_game_1_timer_2_timeout():
		print("game timer over")
		crafting_bg.visible = true
		crafting_window.visible = true
		game_bg.visible = false
		game_window.visible = false
		struct2.queue_free()
		Globals.is_playing = false
		Globals.structure_count += 1
