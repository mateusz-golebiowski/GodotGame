extends Area2D

var velocity 
onready var player = get_node("/root/Node2D/Player")

func _ready():
	position += Vector2.RIGHT.rotated(rotation) * 100

func init(parent, vel):
		position = parent.position
		position.y += 100
		rotation = parent.rotation
		velocity = vel
		parent.get_node("/root/Node2D/bullets").add_child(self)
		
func _process(delta):
	position += Vector2.RIGHT.rotated(0) * velocity * delta
	if position.distance_to(player.position) > 5000:
		queue_free()



func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.is_in_group("player")):
		body.call_deferred("explode")
		get_parent().remove_child(self)
		queue_free()

