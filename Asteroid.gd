extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_exploded := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func explode():
	if is_exploded:
		return

	is_exploded = true

	get_parent().remove_child(self)
	queue_free()
