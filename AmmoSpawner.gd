extends Node2D



var ammo_scene = load("res://Ammo.tscn")

func _ready() -> void:
	_spawn_ammo()

func _spawn_ammo():
	var ammo = ammo_scene.instance()
	_set_ammo_position(ammo)
	_set_ammo_trajectory(ammo)
	add_child(ammo)

func _set_ammo_trajectory(asteroid):
	asteroid.angular_velocity = rand_range(-4, 4)
	asteroid.angular_damp = 0
	asteroid.linear_velocity = Vector2(rand_range(-300, 0), 20)
	asteroid.linear_damp = 0


func _set_ammo_position(asteroid):
	var rect = get_viewport().size
	asteroid.position = Vector2(rect.x, rand_range(0, rect.y))

func _on_Timer_timeout():
	_spawn_ammo() # Replace with function body.
