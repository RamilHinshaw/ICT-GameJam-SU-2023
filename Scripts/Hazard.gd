extends Area2D

var _on_floor:bool = false

func _on_Hazard_body_entered(body):
	if Global.is_world_paused or Global.is_player_paused:
		return
		
#	if body.is_in_group("Floor"):
#		_on_floor = true;
#
#	if (_on_floor):
#		return
	
	if body.name == "Player" or body.name == "Player-ghost":
		body.kill_player()
		Global.reset_level(true)
