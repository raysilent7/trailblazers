extends Area2D

var speed: float = 400.0

func _process(delta: float) -> void:
	global_position.y += speed * delta
	if global_position.y > 725:
		queue_free()

func onBodyEntered(body: Node2D) -> void:
	if body is Player:
		body.hp.damage()
		queue_free()
