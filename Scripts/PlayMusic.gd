extends Node

export var music:AudioStream

func _ready():
	Global.play_music(music)
