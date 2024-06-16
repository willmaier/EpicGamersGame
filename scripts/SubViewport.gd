extends SubViewport

@onready var camera = $Camera2D
var tree_texture = preload("res://prefabs/tree.tscn")

func _ready():
	updateMap()

# Currently this is only viewing trees in the mini map
# but this model is scalable as we can pick and choice
# what gets diplayed and what doesn't.
# Also when a BG is added we can add it here too
func updateMap():
	var tree_path = get_tree().get_root().get_node("Node2D/Resources")
	for i in tree_path.get_child_count():
		var tree = tree_texture.instantiate()
		add_child(tree)
		tree.position = tree_path.get_child(i).position

# TODO may need to fix this to follow the camera instead but the behavior wonky
func _process(delta):
	var CameraPath = get_tree().get_root().get_node("Node2D/Player")
	camera.position = CameraPath.position
