extends Node2D


onready var box_prefab = preload("res://Prefabs/Block_Box.tscn")

var timeLeft = 0.5;

export var left_spawn = -177
export var spawn_units = 23
var unit_size = 16

func _process(dt):
	var t = rand_range(0.5,3)
	yield(get_tree().create_timer(t),"timeout")	
	
	spawn_block()
	



func spawn_block():
	var rdm = rand_range(1,spawn_units)
	
	var location = left_spawn + (unit_size * rdm)
	
	var box = box_prefab.instance()
	self.add_child(box)
	box.global_position.x = rdm
	box.global_position.y = -250
	print("block spawned!")
	
	
	yield(get_tree().create_timer(3),"timeout")	
	queue_free()
	
