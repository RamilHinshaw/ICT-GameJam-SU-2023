extends Button

export var scene: PackedScene
export var grab_focus: bool = false
export var exit_instead: bool = false

func _on_pressed():
	if exit_instead:
		get_tree().quit()
	
	else:
		change_scene()

#Kinda hardcoded eeesh
func _ready():
	if grab_focus():
		grab_focus()
		
func set_focus():
	grab_focus()

func change_scene():
	get_tree().change_scene_to(scene)
