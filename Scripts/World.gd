extends Node2D

export var use_scene_name:bool = false
export var level_name:String = "Level NULL"
export var music:AudioStream

onready var lbl_level:Label = $Label

func _ready():
	Global.play_music(music)
	
	if use_scene_name:
		lbl_level.text = get_tree().get_current_scene().get_name()
	else:
		lbl_level.text = level_name



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

