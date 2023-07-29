extends Area2D

onready var sprite = $Sprite
export var sfx_switch:AudioStream

#terrible code but all well, too lazy to signal this
func _process(delta):
	
	# IF RED
	if (Global.is_selected_vanishing_block_red):
		sprite.frame = 0
		
	# IF BLUE
	else:
		sprite.frame = 1



func _on_Lever_body_entered(body):
	if Global.is_world_paused or Global.is_player_paused:
		return
	
	if body.name == "Player" or body.name == "Player-ghost":
		toggle_lever()

func toggle_lever():
	
	Global.play_sfx(sfx_switch)
	
	# turn Blue
	if sprite.frame == 0:
		#sprite.frame = 1
		Global.is_selected_vanishing_block_red = false
	# turn Red
	else:
		#sprite.frame = 0
		Global.is_selected_vanishing_block_red = true
