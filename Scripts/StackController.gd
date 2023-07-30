extends Node2D

#export(Array, NodePath) var stacks

var _current_index:int = 0

onready var anim := $AnimationPlayer
onready var ui_stack_counter := $Label

onready var stackContainer:Node2D = $StackContainer
var stackss = []

var _is_stackable_mode:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for stack in stackContainer.get_children():
		if stack is Stack:
			stackss.push_back(stack)
	
	set_stacks_visiblity()
	


func _process(delta):
	input()
	
	if (_is_stackable_mode):
		
		if Input.is_action_just_released("ui_right"):
			_current_index += 1
			pass
			
		elif Input.is_action_just_released("ui_left"):
			_current_index -= 1
			pass
		
		if (_current_index >= stackss.size() ):
			_current_index = 0
			
		elif (_current_index < 0 ):
			_current_index = stackss.size() -1
			
		set_stacks_visiblity()
		update_UI()
		
		#HARD CODED FIX!
		if Input.is_action_just_released("ui_up"):
			drop_stack()
			
func drop_stack():
	Global.is_paused = false
	anim.play("Pan_Down")
	_is_stackable_mode = false
	stackss[_current_index].call("activate")


func set_stacks_visiblity():
	#CLEAR ALL FIRST		
	for stack in stackss:
		if stack.has_activated == false:
			stack.call("set_visable", false)
	
	stackss[_current_index].call("set_visable", true)
	
func update_UI():
	var max_size:int = stackss.size()
	ui_stack_counter.text = "Stack: " + str(_current_index+1) + "/" + str(max_size) + "\nResets: " + str(Global.reset_counter)

func input():
	if Input.is_action_just_released("stack_mode"):
		
		if (!_is_stackable_mode):
			anim.play("Pan_Up")

		else:
			anim.play("Pan_Down")
			
		# YIELD THIS IN FUTURE!
		Global.is_paused = !_is_stackable_mode	
		
		_is_stackable_mode = !_is_stackable_mode
