extends Area2D

onready var sprite = $Sprite
export var sfx_on:AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Rod_body_entered(body):
	
	if body.name == "Player" or body.name == "Player-ghost":
#		print("Player entered!")
		sprite.frame = 1
		Global.rod_highlight_modifier(1)
		Global.play_sfx(sfx_on)



func _on_Rod_body_exited(body):
	if body.name == "Player" or body.name == "Player-ghost":
#		print("Player Exited!")
		sprite.frame = 0
		Global.rod_highlight_modifier(-1)
