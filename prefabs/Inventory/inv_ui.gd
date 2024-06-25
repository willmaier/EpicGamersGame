extends Control

#@onready var inv: Inv = preload("res://prefabs/Inventory/Player_Inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


@onready var inventory = preload("res://prefabs/Inventory/Player_Inv.tres")





@onready var inv_slot1 =  $NinePatchRect/GridContainer/Inventory_slot/inv_sprite1
@onready var inv_slot2 =  $NinePatchRect/GridContainer/Inventory_slot2/inv_sprite2
@onready var inv_slot3 =  $NinePatchRect/GridContainer/Inventory_slot3/inv_sprite3
@onready var inv_slot4 =  $NinePatchRect/GridContainer/Inventory_slot4/inv_sprite4
@onready var inv_slot5 =  $NinePatchRect/GridContainer/Inventory_slot5/inv_sprite5
@onready var inv_slot6 =  $NinePatchRect/GridContainer/Inventory_slot6/inv_sprite6
@onready var inv_slot7 =  $NinePatchRect/GridContainer/Inventory_slot7/inv_sprite7
@onready var inv_slot8 =  $NinePatchRect/GridContainer/Inventory_slot8/inv_sprite8
@onready var inv_slot9 =  $NinePatchRect/GridContainer/Inventory_slot9/inv_sprite9
@onready var inv_slot10 = $NinePatchRect/GridContainer/Inventory_slot10/inv_sprite10



@onready var slot_label1 =  $NinePatchRect/GridContainer/Inventory_slot/sizenode/slotlabel1
@onready var slot_label2 =  $NinePatchRect/GridContainer/Inventory_slot2/sizenode/slotlabel1
@onready var slot_label3 =  $NinePatchRect/GridContainer/Inventory_slot3/sizenode/slotlabel1
@onready var slot_label4 =  $NinePatchRect/GridContainer/Inventory_slot4/sizenode/slotlabel1
@onready var slot_label5 =  $NinePatchRect/GridContainer/Inventory_slot5/sizenode/slotlabel1
@onready var slot_label6 =  $NinePatchRect/GridContainer/Inventory_slot6/sizenode/slotlabel1
@onready var slot_label7 =  $NinePatchRect/GridContainer/Inventory_slot7/sizenode/slotlabel1
@onready var slot_label8 =  $NinePatchRect/GridContainer/Inventory_slot8/sizenode/slotlabel1
@onready var slot_label9 =  $NinePatchRect/GridContainer/Inventory_slot9/sizenode/slotlabel1
@onready var slot_label10 = $NinePatchRect/GridContainer/Inventory_slot10/sizenode/slotlabel1

@onready var inv_slots = [[inv_slot1, slot_label1],[inv_slot2, slot_label2],[inv_slot3, slot_label3],[inv_slot4, slot_label4],[inv_slot5, slot_label5],[inv_slot6, slot_label6],
					[inv_slot7, slot_label7],[inv_slot8, slot_label8],[inv_slot9, slot_label9],[inv_slot10, slot_label10]]



var is_open = false

func _ready():
	update_slots()
	close()

func _process(_delta):
	update_slots()
	if Input.is_action_just_pressed("toggle_inventory"):
		if is_open:
			close()
		else:
			open()
			

func update_slots():
	for i in range(len(inventory.inventory)):
		var item = inventory.inventory[i]
		inv_slots[i][0].texture =  item[0].texture
		inv_slots[i][1].text = str(item[1])
		#print(inv_slots[i][1])
				
			
				
				
	

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
