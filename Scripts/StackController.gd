extends Node2D

export(Array, NodePath) var stacks

var _current_index:int = 0

onready var anim := $AnimationPlayer

var _is_stackable_mode:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	show_current_stack()
	


func _process(delta):
	input()
	
	if (_is_stackable_mode):
		
		if Input.is_action_just_released("ui_right"):
			_current_index += 1
			pass
			
		elif Input.is_action_just_released("ui_left"):
			_current_index -= 1
			pass
		
		if (_current_index >= stacks.size() ):
			_current_index = 0
			
		elif (_current_index < 0 ):
			_current_index = stacks.size() -1
			
		show_current_stack()
		
		#HARD CODED FIX!
		if Input.is_action_just_released("ui_up"):
			Global.is_paused = false
			anim.play("Pan_Down")
			_is_stackable_mode = false
			get_node(stacks[_current_index]).call("activate")


func show_current_stack():
	#CLEAR ALL FIRST		
	for stack in stacks:
		get_node(stack).call("set_visable", false)
	
	get_node(stacks[_current_index]).call("set_visable", true)

func input():
	if Input.is_action_just_released("stack_mode"):
		
		if (!_is_stackable_mode):
			anim.play("Pan_Up")

		else:
			anim.play("Pan_Down")
			
		# YIELD THIS IN FUTURE!
		Global.is_paused = !_is_stackable_mode	
		
		_is_stackable_mode = !_is_stackable_mode
