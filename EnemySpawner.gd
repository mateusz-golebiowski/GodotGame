extends Node2D



var enemy_scene = load("res://Enemy.tscn")

func _ready() -> void:
	_spawn_enemy()

func _spawn_enemy():
	var enemy = enemy_scene.instance()
	_set_enemy_position(enemy)
	add_child(enemy)



func _set_enemy_position(asteroid):
	var rect = get_viewport().size
	asteroid.position = Vector2(rect.x+100, rand_range(0, rect.y))

func _on_Timer_timeout():
	_spawn_enemy() # Replace with function body.
