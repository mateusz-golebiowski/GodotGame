extends KinematicBody2D


export var speed = 200
export var ammo = 100
var screen_size 
var health = 100


var velocity = Vector2()
var Bullet = preload("res://Bullet.tscn")

var lastShoot = OS.get_ticks_msec()

func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	if health <= 0:
		get_tree().change_scene("res://GameOver.tscn")

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
		if OS.get_ticks_msec() - lastShoot > 100 and ammo > 0:
			ammo -= 1;
			print(ammo)
			Bullet.instance().init(self, 1000)
			lastShoot = OS.get_ticks_msec()
	velocity = velocity.normalized() * speed



func _physics_process(delta):
	get_input(delta)
	velocity = move_and_collide(velocity*delta)



func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.is_in_group("asteroids")):
		body.call_deferred("explode")
		health -= 100
		print(health)
	if (body.is_in_group("ammo")):
		body.call_deferred("destroy")
		ammo += 50
		print(ammo)
