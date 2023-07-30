extends Node2D

export var use_scene_name:bool = false
export var level_name:String = "Level NULL"
#export var music:AudioStream

signal coin_collected

var coins_left:int = 0

onready var lbl_level:Label = $Label

# JANK MULTIPLAYER
onready var player2_prefab = preload("res://Prefabs/Player2.tscn")

func _ready():
#	Global.play_music(music)
	
#	if use_scene_name:
#		lbl_level.text = get_tree().get_current_scene().get_name()
#	else:
#		lbl_level.text = level_name
	lbl_level.text = "Level " + str(Global.current_level+1)	
	
	if Global.is_multiplayer:
		spawn_player2()	


	# SET ALL COINS
#	for coin in self.get_children():
	var coins = get_tree().get_nodes_in_group("Coin")
	for coin in coins:
		if coin is Coin:
			if coin.has_method("set_world"):
				coin.set_world(self)
				coins_left += 1

func spawn_player2():
	# Because we lose reference on spawn and will use to spawn ontop of player
	
	var temp_player = get_tree().get_nodes_in_group("Player")
	
	# Spawn Player 2
	var player2 = player2_prefab.instance()
	self.add_child(player2)
	player2.global_position = temp_player[0].global_position
	print("SPAWNED PLAYER 2!")

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

