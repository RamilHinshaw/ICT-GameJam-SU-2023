extends Node2D

class_name Stack

func _ready():
	
	#Start all blocks frozen in this stack
	set_freeze_children(true)

func set_visable(val:bool):
	self.visible = val
	
func activate():
	# Get all block under this and set to not frozen!
	set_freeze_children(false)
	pass
	
func set_freeze_children(val:bool):
	for child in self.get_children():
		print(child.name)
#		if child is Block:
		if child.has_method("set_freeze"):
			child.set_freeze(val)
	
