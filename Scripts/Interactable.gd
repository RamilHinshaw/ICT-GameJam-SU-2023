extends Node

class_name Interactable
#signal on_interact
export(int, "Interact", "AutoStart", "Trigger") var ActivationType
export var nodePath:NodePath
export var methodName:String

func _ready():
	if ActivationType == 1:
		interact()

func _on_body_entered(body): #can optimize this by disabling detection _ready
	if ActivationType == 2:
		interact()

func interact():
	get_node(nodePath).call(methodName)
