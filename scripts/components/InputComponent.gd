class_name InputComponent extends Node

var direction: Vector2 = Vector2.ZERO
var shoot: bool = false
var pause: bool = false

func readInputs():
	direction = Input.get_vector("left", "right", "up", "down")
	pause = Input.is_action_just_pressed("pause")
	shoot = Input.is_action_pressed("shoot")
