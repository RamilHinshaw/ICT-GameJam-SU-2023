extends Area2D

export var sfx_shift:AudioStream

var _can_use:bool = true


func _on_GravityShift_body_entered(body):
	if Global.is_world_paused or Global.is_player_paused:
		return
		
	if (_can_use == false):
		return
	
	if body.name == "Player" or body.name == "Player-ghost":
		body.shift_gravity()
		Global.play_sfx(sfx_shift)
		_can_use = false
		
		yield(get_tree().create_timer(0.25), "timeout")
		_can_use = true
