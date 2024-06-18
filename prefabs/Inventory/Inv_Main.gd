extends Resource


@export var inventory = []

func load_inventory():
	pass
	

func add_item(item_path: String, quantity: int):
	var item = load(item_path)
	if item:
		var found = false
		for item_pair in inventory:
			if item_pair[0].item_name == item.item_name:
				item_pair[1] += quantity
				found = true
				break
		if not found:
			inventory.append([item, quantity])


func print_inventory():
	for item_pair in inventory:
		var item = item_pair[0].item_name
		var quantity = item_pair[1]
		print("Item: %s, Quantity: %d" % [item, quantity])
