extends CanvasGroup

@onready var sticks = $Sticks
@onready var rocks = $Rocks

func _process(delta):
	sticks.text = "Sticks collected: " +  str(Globals.stick_count)
	rocks.text = "Rocks collected: " +  str(Globals.rock_count)
