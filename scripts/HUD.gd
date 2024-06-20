extends CanvasGroup

@onready var sticks = $Sticks
@onready var rocks = $Rocks
@onready var hammers = $Hammers

func _process(_delta):
	sticks.text = "Sticks collected: " +  str(Globals.stick_count)
	rocks.text = "Rocks collected: " +  str(Globals.rock_count)
	#hammers.text = "Hammers made: " +  str(Globals.hammer_count)
