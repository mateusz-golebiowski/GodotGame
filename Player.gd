extends KinematicBody2D

# Declare member variables here. Examples:
export var speed = 200
var screen_size # Size of the game window.

var velocity = Vector2()
var Bullet = preload("res://Bullet.tscn")
var lastShoot = OS.get_ticks_msec()
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print('test')

		

func get_input(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		print('up')
		velocity.y -= 1
	if Input.is_action_pressed("fire"):
		if OS.get_ticks_msec() - lastShoot > 100:
			Bullet.instance().init(self, 1000)
			lastShoot = OS.get_ticks_msec()
	velocity = velocity.normalized() * speed



func _physics_process(delta):
	get_input(delta)
	velocity = move_and_collide(velocity*delta)
