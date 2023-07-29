extends Area2D

func _on_Hazard_body_entered(body):
	if Global.is_world_paused or Global.is_player_paused:
		return
	
	if body.name == "Player" or body.name == "Player-ghost":
		body.kill_player()
		Global.reset_level(true)
