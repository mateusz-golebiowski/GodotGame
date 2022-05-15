extends RigidBody2D

# Declare member variables here. Examples:
export var speed = 800
var screen_size # Size of the game window.

var animation = 'idle'
var started = false
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

var rad = 0.01
var addRad = 0.05
export (int) var engine_thrust
export (int) var spin_thrust

var thrust = Vector2()
var rotation_dir = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if not started:
		if rad >= 1:
			addRad = -addRad
		elif rad <= 0.01:
			addRad = -addRad	
		rad += addRad
	

	$AnimatedSprite.play(animation)

		

func _input(ev):
	if Input.is_key_pressed(KEY_SPACE):
		animation = 'default'
		if started:
			thrust = Vector2(engine_thrust, 0)
			rotation_dir -= 1
		else:
			if (rotation_dir <= 0):
				rotation_dir += 1
			started = true
			get_parent().speed = speed
	else:
		animation = 'idle'
		thrust = Vector2()



func _physics_process(delta):
	print(rotation)
	set_applied_force(thrust.rotated(rotation - PI/2))
	set_applied_torque(rotation_dir * spin_thrust)
