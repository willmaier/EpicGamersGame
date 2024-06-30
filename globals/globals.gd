extends Node

# Player booleans
var is_paused: bool = false
var is_crafting: bool = false
var in_inventory: bool = false
var is_playing: bool = false
var harvest_speed: int = 5

# Inventory
var stick_count: int = 0
var rock_count: int = 0
var hammer_tool = false
var pickaxe_tool = false

# Music control
var structure_count: int = 0

# Planting
var can_plant = true

# Dialogue
var has_enough = false

