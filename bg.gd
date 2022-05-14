extends ParallaxBackground




var direction = Vector2(1, 0)

func _process(delta):
	scroll_offset.x -=  get_parent().speed * delta

