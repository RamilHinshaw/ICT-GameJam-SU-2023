extends RigidBody2D

class_name BlockRB

onready var col = $CollisionShape2D
#export var acceleration:float = 512
#export var max_speed:float = 64
export var gravity:float = 200
#export var air_resistance:float = 0.02
export var is_frozen:bool = false

var motion = Vector2.ZERO

var start_x_pos: float
func _ready():
	start_x_pos = self.global_position.x


func _physics_process(dt):
	self.global_position.x = start_x_pos
	self.rotation_degrees = 0
#	angular_velocity = 0

	if is_frozen:
		return
	
#	motion.y = fall(dt, motion)
#
#	if Global.is_paused:
#		return
#
#	if (is_on_floor()):
#		motion = Vector2.ZERO
#		return
##	motion.x = 0
#
#	var col = move_and_collide(motion*dt)
#
#	if (col):
#		motion = Vector2.ZERO
#	motion = move_and_slide(motion, Vector2.UP, false, 4, 0.785398,false)
#	motion = move_and_slide(motion, Vector2.UP)
	
	

#func fall(dt, motion):
#	motion.y += gravity * dt
#	return motion.y
	
func set_freeze(val):
	is_frozen = val
	col.disabled = val
