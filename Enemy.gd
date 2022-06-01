extends KinematicBody2D

export var speed = 250
var lastShoot = OS.get_ticks_msec()
var lastTurn = OS.get_ticks_msec()
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var BulletEnemy = preload("res://BulletEnemy.tscn")
var posY = 0
var is_exploded = false 
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var id_exploded = false

func move_enemy(delta):
	velocity = Vector2()
	var rect = get_viewport().size
	velocity.x -= rect.x
	if OS.get_ticks_msec() - lastTurn > 2000:
		posY = rng.randi_range(1000, -1000)
		lastTurn = OS.get_ticks_msec()
	velocity.y += posY
	if OS.get_ticks_msec() - lastShoot > 1500:
		BulletEnemy.instance().init(self, -800)

		lastShoot = OS.get_ticks_msec()
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	
	move_enemy(delta)
	
	velocity = move_and_collide(velocity*delta)
	if position.x < -100: 
		get_parent().remove_child(self)
		queue_free()
func explode():
	if is_exploded:
		return

	is_exploded = true

	get_parent().remove_child(self)
	queue_free()
