extends Area2D

var speed: float = 400.0

func _process(delta: float) -> void:
	global_position.y -= speed * delta
	if global_position.y < 0:
		queue_free()

func onAreaEntered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		queue_free()
