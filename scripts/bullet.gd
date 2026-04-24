extends Area2D

var speed: float = 400.0

func _process(delta: float) -> void:
	position.y -= speed * delta
	if position.y < -1000:
		queue_free()

func onAreaEntered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		queue_free()
