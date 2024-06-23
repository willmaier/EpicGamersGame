extends Resource

class_name Inv_Item


@export var name: String = "Stick,Rock"
@export var texture: Texture2D
@export_range(1,max_stack_size) var quantity: int = 1
@export_multiline var description: String = ""

const max_stack_size: int = 99
