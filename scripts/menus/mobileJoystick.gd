extends Node2D

var radius := 80.0
var touchId := -1
var output := Vector2.ZERO

func _input(event):
	if event is InputEventScreenTouch and event.pressed and touchId == -1:
		touchId = event.index
		updateStick(event.position)

	elif event is InputEventScreenDrag and event.index == touchId:
		updateStick(event.position)

	elif event is InputEventScreenTouch and not event.pressed and event.index == touchId:
		touchId = -1
		output = Vector2.ZERO
		resetStick()

func updateStick(screenPos):
	var localPos = to_local(screenPos)
	var center = $base.position
	var dir = localPos - center

	if dir.length() > radius:
		dir = dir.normalized() * radius

	$stick.position = center + dir
	output = dir / radius

func resetStick():
	$stick.position = $base.position
