extends Button

export var scene: PackedScene
export var grab_focus: bool = false
export var exit_instead: bool = false

export var set_mp:bool = false

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
	if (set_mp):
		Global.is_multiplayer = true
	
	get_tree().change_scene_to(scene)
