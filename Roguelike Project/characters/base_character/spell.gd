extends Node2D

var travelled_distance = 0

func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 1200
	
	var direction = Vector2.RIGHT.rotated(rotation)
	
	position += direction * SPEED * delta

	travelled_distance += SPEED * delta

	if travelled_distance > RANGE:
		queue_free()
