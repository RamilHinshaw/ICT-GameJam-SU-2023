extends KinematicBody2D

class_name Block

onready var col = $CollisionShape2D

var cols = []
#onready var raycast:RayCast2D = $RayCast2D
onready var hazard:Area2D = $Hazard
var hazards = []
#export var acceleration:float = 512
#export var max_speed:float = 64
export var gravity:float = 200
#export var air_resistance:float = 0.02
export var is_frozen:bool = false

export var disable_motion:bool = false

var raycasts = []

var colliding_with

var motion = Vector2.ZERO

var start_x_pos: float

func _ready():
	start_x_pos = self.global_position.x
	
	#Get all raycast on this object
	for _raycast in self.get_children():
		if _raycast is RayCast2D:
			raycasts.push_back(_raycast)
			
	#Get all raycast on this object
	for _col in self.get_children():
		if _col is CollisionShape2D:
			cols.push_back(_col)

	for _hazard in self.get_children():
		if _hazard is Hazard:
			hazards.push_back(_hazard)

func _process(dt):
#func _physics_process(dt):
	
	if is_frozen or disable_motion:
		return
	
	motion.y = fall(dt, motion)
	
	var max_speed = 250
	if (motion.y > max_speed):
		motion.y = max_speed
	
#	print(motion.y)
	
			
	colliding_with = move_and_collide(motion*dt)

	var hit_detected:bool = false

	for _raycast in raycasts:
		if _raycast.is_colliding():
#			if (_raycast.get_collider().is_in_group("Floor") or _raycast.get_collider().is_in_group("Vanish")):
			hit_detected = true
		
	if hit_detected:		
		motion = Vector2.ZERO
#		hazard.set_monitoring(false)

		for _hazard in hazards:
			_hazard.set_monitoring(false)
	else:
#		hazard.set_monitoring(true)

		for _hazard in hazards:
			_hazard.set_monitoring(true)
				

#	motion = move_and_slide(motion, Vector2.UP, false, 4, 0.785398,false)
#	motion = move_and_slide(motion, Vector2.UP)
	
	self.global_position.x = start_x_pos
	
	
func get_motion() -> Vector2:
	return motion

func fall(dt, motion):
	motion.y += gravity * dt
	return motion.y
	
func set_freeze(val):
	is_frozen = val
	
	for _col in cols:
		_col.disabled = val
