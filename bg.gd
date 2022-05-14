extends ParallaxBackground

export(int) var speed: int = 1000


var direction = Vector2(1, 0)

func _process(delta):
	scroll_offset.x -=  speed * delta

