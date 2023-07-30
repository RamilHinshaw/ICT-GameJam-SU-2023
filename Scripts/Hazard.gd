extends Area2D

class_name Hazard

var _on_floor:bool = false

func _on_Hazard_body_entered(body):
	if Global.is_world_paused or Global.is_player_paused:
		return
		
#	if body.is_in_group("Floor"):
#		_on_floor = true;
#
#	if (_on_floor):
#		return
#	if body.is_in_group("Player"):
#		body.kill_player()
#		Global.reset_level(true)
	if body.name == "Player" or body.name == "Player2":
		body.kill_player()
		Global.reset_level(true)
