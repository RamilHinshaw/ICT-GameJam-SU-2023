extends KinematicBody2D

onready var anim = $AnimationPlayer
onready var sprite = $Sprite
onready var col = $CollisionShape2D

export var acceleration:float = 512
export var max_speed:float = 64
export var friction:float = 0.25
export var gravity:float = 200
export var air_resistance:float = 0.02
export var jump_force:float = 128

export var invert_xinput:int = 1

export var inverted_gravity:int = 1 

var _can_change_gravity:bool = true

var motion = Vector2.ZERO

#AUDIO
export var sfx_death:AudioStream
export var sfx_jump:AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
#func _process(delta):
##	if Input.is_action_just_released("ui_spin"):
#
#
##		inverted_gravity = -inverted_gravity * inverted_gravity
##		sprite.flip_v = !sprite.flip_v
	
func _physics_process(dt):
	
	# Don't do anything if world is spinning!
	if (Global.is_player_paused):
		return
	
	var x_input = 0
	var jump_input = "ui_up"
		
	if (Global.is_world_paused == false):
		
		x_input = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * invert_xinput
		motion.x = movement(dt, motion, x_input)
		motion.y = jump(dt, motion, jump_input)
		
	motion.y = fall(dt, motion)
	update_animations(x_input)
	

	if Global.is_world_paused:
		motion.x = 0

	motion = move_and_slide(motion, Vector2.UP)


func movement(dt, motion, x_input):		
		
	if x_input != 0:
		motion.x += x_input * acceleration * dt
		motion.x = clamp(motion.x, -max_speed, max_speed)
		sprite.flip_h = (x_input * inverted_gravity) < 0
		
	if (is_on_floor() && inverted_gravity == 1) or (is_on_ceiling() && inverted_gravity == -1):
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, friction)
	else:	
		if x_input == 0:
			motion.x = lerp(motion.x, 0, air_resistance)
			
	return motion.x
	
func fall(dt, motion):
	motion.y += (gravity * inverted_gravity) * dt
	return motion.y
	
func jump(dt, motion, jump_input):
	
	if (is_on_floor() && inverted_gravity == 1) or (is_on_ceiling() && inverted_gravity == -1):
		if (Input.is_action_just_pressed(jump_input)):
			motion.y = (-jump_force * inverted_gravity)
			Global.play_sfx(sfx_jump)
	else:
		if Input.is_action_just_released(jump_input) and (motion.y*inverted_gravity) < -jump_force/2:
			motion.y = (-jump_force * inverted_gravity)/2
		
	return motion.y
	
func update_animations(x_input):
	if (is_on_floor() && inverted_gravity == 1) or (is_on_ceiling() && inverted_gravity == -1):
		if x_input == 0:
			anim.play("Idle")
		else:
			anim.play("Move")	
	else:
		anim.play("Airborne")

func kill_player():
	visible = false
	col.disabled = true
	Global.play_sfx(sfx_death)

func shift_gravity():
	if inverted_gravity == 1:
		#sprite.flip_v = true
		sprite.flip_h = true
		rotation_degrees = 180
		inverted_gravity = -1
	else:
		#sprite.flip_v = false
		sprite.flip_h = false
		rotation_degrees = 0		
		inverted_gravity = 1
	
	_can_change_gravity = false
		
	yield(get_tree().create_timer(5), "timeout")
	_can_change_gravity = true
