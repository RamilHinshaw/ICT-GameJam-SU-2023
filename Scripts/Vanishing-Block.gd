extends KinematicBody2D

export var is_red:bool = true
onready var sprite = $Sprite
onready var col = $CollisionShape2D


#terrible code but all well, too lazy to signal this
func _process(delta):
	
	# IF RED
	if (Global.is_selected_vanishing_block_red && is_red):
		sprite.frame = 1
		col.disabled = false
		
	# IF BLUE
	elif (Global.is_selected_vanishing_block_red == false && is_red == false):
		sprite.frame = 1
		col.disabled = false
	
	# IF CONDITION NOT MET
	else:
		sprite.frame = 0
		col.disabled = true
