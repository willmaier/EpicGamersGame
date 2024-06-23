extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
# Inventory visibility toggle
func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
