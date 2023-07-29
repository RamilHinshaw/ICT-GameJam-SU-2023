extends KinematicBody2D

class_name Block

onready var col = $CollisionShape2D
onready var raycast:RayCast2D = $RayCast2D
#export var acceleration:float = 512
#export var max_speed:float = 64
export var gravity:float = 200
#export var air_resistance:float = 0.02
export var is_frozen:bool = false

var colliding_with

var motion = Vector2.ZERO

var start_x_pos: float

func _ready():
	start_x_pos = self.global_position.x

func _process(dt):
#func _physics_process(dt):
	
	if is_frozen or Global.is_paused:
		return
	
	motion.y = fall(dt, motion)
	
#	if Global.is_paused:
#		return
		
#	if (is_on_floor()):
#
##		motion = Vector2.ZERO
#		return
#	motion.x = 0
			
	colliding_with = move_and_collide(motion*dt)
	
	if (colliding_with):
#		motion = Vector2.ZERO

		if (raycast == null):
			return
			
		if (raycast.is_colliding()):
			if (raycast.get_collider().is_in_group("Floor")):
				motion = Vector2.ZERO
#			print("COLLIDING!")
			
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
	col.disabled = val
