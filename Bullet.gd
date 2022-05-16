extends Area2D

var velocity 
onready var player = get_node("/root/Node2D/Player")

func _ready():
	position += Vector2.RIGHT.rotated(rotation) * 100

func init(parent, vel):
		position = parent.position
		rotation = parent.rotation
		velocity = vel
		parent.get_node("/root/Node2D/bullets").add_child(self)
		
func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * velocity * delta
	if position.distance_to(player.position) > 5000:
		queue_free()

