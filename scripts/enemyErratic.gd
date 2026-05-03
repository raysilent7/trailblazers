extends "res://scripts/enemy.gd"

var lateralSpeed := 600.0
var screenMargin := 10.0
var dir := 0
var timeToChange := 0.0

func _ready():
	pickNewDirection()
	mainScene = get_tree().current_scene

func pickNewDirection():
	dir = randi_range(-1, 1)
	timeToChange = randf_range(1.0, 1.6)

func _process(delta):
	timeToChange -= delta
	var viewport = get_viewport_rect()

	if timeToChange <= 0:
		pickNewDirection()

	if global_position.x < screenMargin:
		dir = 1
	elif global_position.x > viewport.size.x - screenMargin:
		dir = -1

	position.x += dir * lateralSpeed * delta
	position.y += GameState.speedY * delta

	if global_position.y > 750:
		GameState.totalEnemies -= 1
		if GameState.totalEnemies <= 0:
			GameState.totalEnemies = 0
			mainScene.startPreparationTimer()
		call_deferred("queue_free")
