extends "res://Scripts/Interactable.gd"

onready var dialog = $Control/BG/FG/Text
onready var textbox = $Control/BG
#onready var portrait = $Control/Portrait
onready var control = $Control
onready var timer = $Control/Timer

signal on_finish
#signal on_finished_dialog

#private
var _dialogs = []
var _dialog_index:int = 0
var _dialog_max_index:int
var _is_talking:bool = false
var _text_speed = 0.025
var _is_waiting_input:bool = false

func _ready():
	control.visible = false
	textbox.visible = false
#	portrait.visible = false
	
func _process(delta):
	if _is_waiting_input == true && Input.is_action_just_pressed("ui_accept"):
		if _dialog_index != _dialog_max_index-1:
			_dialog_index += 1
			StartTalk()
	
		else:
			control.visible = false
			textbox.visible = false
			Global.pause(false)
			emit_signal("on_finish")
			
	pass
	pass


func LoadDialog(dialogs):
	_dialogs = dialogs
	_dialog_index = 0
	_dialog_max_index = dialogs.size()
#	print(_dialog_max_index)
	pass

	
func StartTalk() -> void:
#	emit_signal("on_start_dialog")
	Global.pause(true)
	
	_is_waiting_input = false
	self.dialog.text = _dialogs[_dialog_index]
	self.dialog.set_visible_characters(0)
#	_is_talking = true
	control.visible = true
	textbox.visible = true

	timer.start(_text_speed)	




func _on_Timer_timeout():
	dialog.set_visible_characters(dialog.get_visible_characters()+1)
	
	if dialog.get_visible_characters() < dialog.get_total_character_count():
		timer.start(_text_speed)
	
	else:
		_is_waiting_input = true
