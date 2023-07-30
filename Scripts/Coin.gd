extends Area2D

class_name Coin

#AUDIO
export var sfx_coin:AudioStream

onready var sprite = $Sprite
onready var col = $CollisionShape2D

onready var _world

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", self, "_on_body_entered")
#	self.connect("body_exited", self, "_on_body_exited")

func _on_body_entered(body):
	
	if body.name == "Player" or body.name == "Player2":
		print("Player entered!")
		Global.play_sfx(sfx_coin)
		visible = false
		col.disabled = true
		_world.coin_captured()
		queue_free()
#		sprite.frame = 1
#		Global.rod_highlight_modifier(1)


#func _on_body_exited(body):
#	if body.name == "Player" or body.name == "Player-ghost":
#		print("Player Exited!")
#		visible = false
##		sprite.frame = 0
##		Global.rod_highlight_modifier(-1)

func set_world(world):
	_world = world
