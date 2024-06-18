extends SubViewport

@onready var camera = $Camera2D
var tree_texture = preload("res://prefabs/minimap_sprites/tree.tscn")
var rock_texture = preload("res://prefabs/minimap_sprites/rock.tscn")
var entity

func _ready():
	updateMap()

# Currently this is only viewing trees in the mini map
# but this model is scalable as we can pick and choice
# what gets diplayed and what doesn't.
# Also when a BG is added we can add it here too
func updateMap():
	var resource_entity_path = get_tree().get_root().get_node("Main/Resources")
	# For all instances in the Resources node
	for i in resource_entity_path.get_child_count():
		if resource_entity_path.get_child(i)._type == "Stick":
			entity = tree_texture.instantiate()
		if resource_entity_path.get_child(i)._type == "Rock":
			entity = rock_texture.instantiate()
		else:
			entity = tree_texture.instantiate()
		add_child(entity)
		entity.position = resource_entity_path.get_child(i).position

# TODO may need to fix this to follow the camera instead but the behavior wonky
func _process(delta):
	var CameraPath = get_tree().get_root().get_node("Main/Player")
	camera.position = CameraPath.position
