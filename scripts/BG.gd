extends Parallax2D

var scroll_speed := 20.0

func _process(delta):
	scroll_offset.y += scroll_speed * delta
