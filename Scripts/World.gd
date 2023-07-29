extends Node2D

export var use_scene_name:bool = false
export var level_name:String = "Level NULL"
#export var music:AudioStream

signal coin_collected

var coins_left:int = 0

onready var lbl_level:Label = $Label

func _ready():
#	Global.play_music(music)
	
	if use_scene_name:
		lbl_level.text = get_tree().get_current_scene().get_name()
	else:
		lbl_level.text = level_name


	# SET ALL COINS
#	for coin in self.get_children():
	var coins = get_tree().get_nodes_in_group("Coin")
	for coin in coins:
		if coin is Coin:
			if coin.has_method("set_world"):
				coin.set_world(self)
				coins_left += 1

func coin_captured():
	coins_left -= 1
	
	if (coins_left <= 0):
		Global.next_level()
#onready var anim = $AnimationPlayerrr
#
#var isUpsideDown:bool = false
#
#func _process(delta):
#	if Input.is_action_just_released("ui_spin"):		
#
#		Global.is_player_paused = true
#
#		if isUpsideDown == false:
#			anim.play("To_UpsideDown")			
#
#		else:
#			anim.play("To_Orig")
#
#		isUpsideDown = !isUpsideDown
#		yield(anim, "animation_finished")
#		Global.is_player_paused = false

