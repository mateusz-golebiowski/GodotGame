extends KinematicBody2D


export var speed = 200
export var ammo = 100
var screen_size 
var health = 100


var velocity = Vector2()
var Bullet = preload("res://Bullet.tscn")

var lastShoot = OS.get_ticks_msec()
var playedExplosion = false 
var is_exploded = false 

var upPressed = false
var leftPressed = false
var rightPressed = false
var downPressed = false
var firePressed = false

func _ready():
	Global.ammo = ammo
	screen_size = get_viewport_rect().size
	$AnimatedSprite.connect("animation_finished", self, "game_over")

func game_over():
	if($AnimatedSprite.animation == "explosion"):
		get_tree().change_scene("res://GameOver.tscn")
func _process(delta):
	if health <= 0:
		$AnimatedSprite.play('explosion')
		if not playedExplosion: 
			$Explosion.play()
			playedExplosion = true
		var scale = Vector2()
		scale.x= 3
		scale.y = 3
		$AnimatedSprite.scale = scale


func get_input(delta):
	velocity = Vector2()
	var rect = get_viewport().size
	if Input.is_action_pressed("ui_right") or rightPressed:
		velocity.x += 1
	if Input.is_action_pressed("ui_left") or leftPressed:
		velocity.x -= 1
	if Input.is_action_pressed("ui_down") or downPressed:
		velocity.y += 1
	if Input.is_action_pressed("ui_up") or upPressed:
		velocity.y -= 1

	if Input.is_action_pressed("fire") or firePressed:
		if OS.get_ticks_msec() - lastShoot > 100 and Global.ammo > 0:
			Global.ammo -= 1;
			Bullet.instance().init(self, 1000)
			$Shoot.play()
			lastShoot = OS.get_ticks_msec()
	velocity = velocity.normalized() * speed



func _physics_process(delta):
	if($AnimatedSprite.animation != "explosion"):
		get_input(delta)
		
		velocity = move_and_collide(velocity*delta)



func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):

	if (body.is_in_group("asteroids")):
		body.call_deferred("explode")
		health -= 100

	if (body.is_in_group("ammo")):
		body.call_deferred("destroy")
		Global.ammo += 50


func explode():
	if is_exploded:
		return

	is_exploded = true
	health -= 100
	


func _on_Up_pressed():
	upPressed = true


func _on_down_pressed():
	downPressed = true

func _on_left_pressed():
	leftPressed = true


func _on_right_pressed():
	rightPressed = true


func _on_Shoot_pressed():
	firePressed = true


func _on_Up_released():
	upPressed = false # Replace with function body.


func _on_down_released():
	downPressed = false


func _on_left_released():
	leftPressed = false


func _on_right_released():
	rightPressed = false


func _on_Shoot_released():
	firePressed = false
