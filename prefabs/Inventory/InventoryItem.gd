extends Resource

class_name Inv_Item

@export var item_name: String 
@export var description: String
@export var texture: Texture2D

@export var item_path: String


func print_desc():
	print(description)
