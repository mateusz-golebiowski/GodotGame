extends Area2D


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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.

	velocity.x += 360 *  sin(rad)
	velocity.y -= 360 *  cos(rad)
	if not started:
		if rad >= 1:
			addRad = -addRad
		elif rad <= 0.01:
			addRad = -addRad	
		rad += addRad
	
	if velocity.length() > 0:
		rotation = rad
		if started:

			velocity = velocity.normalized() * speed
			position += velocity * delta

		$AnimatedSprite.play(animation)
	else:
		$AnimatedSprite.stop()

func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_SPACE:
		animation = 'default'
		var velocity = Vector2.ZERO # The player's movement vector.
		velocity.x += 1
		started = true
		get_parent().speed = speed
		
