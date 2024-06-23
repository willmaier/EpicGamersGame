extends Control

@onready var inv: Inv = preload("res://prefabs/Inventory/Slot_data/Player_Inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	update_slots()
	close()

func _process(_delta):
	if Input.is_action_just_pressed("toggle_inventory"):
		if is_open:
			close()
		else:
			open()
# update visible inventory slots
func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])
# inventory UI toggle
func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
