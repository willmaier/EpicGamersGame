extends Node2D

@export var bridge: Sprite2D
@export var missing_bridge: CollisionShape2D
var crash_sound
var bridge_broken = false

func _ready():
	missing_bridge = $MissingBridge/CollisionShape2D
	crash_sound = $MissingBridge/CrashSound

func _on_bridge_break_body_entered(body):
	if (!bridge_broken):
		print("bridge broken")
		bridge.visible = false
		missing_bridge.set_deferred("disabled", false)
		#play sound effect
		crash_sound.play()
		bridge_broken = true

func _on_tutorial_area_body_entered(body):
	$TutorialArea/Intro.visible = true

func _on_tutorial_area_body_exited(body):
	$TutorialArea/Intro.visible = false
