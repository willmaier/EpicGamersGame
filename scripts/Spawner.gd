extends Node

@export var resource_node : PackedScene

var random = RandomNumberGenerator.new()

# Creates new instance of resource and sets a random location
func new_resource():
	var posx = random.randi_range(20, 1000)
	var posy = random.randi_range(20, 500)
	var resource = resource_node.instantiate()
	# need to offset y due to scene pos issues
	resource.position = Vector2(posx,posy)
	get_tree().current_scene.add_child.call_deferred(resource)

func _on_spawn_timer_timeout():
	new_resource()
