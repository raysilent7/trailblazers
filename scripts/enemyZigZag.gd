extends "res://scripts/enemy.gd"

var amplitude: float = 200.0
var frequency: float = 3.0
var dir: int = 0
var time: float = 0.0

func _ready():
	dir = [-1, 1].pick_random()
	mainScene = get_tree().current_scene

func _process(delta):
	time += delta
	position.x += sin(time * frequency) * amplitude * delta * dir
	position.y += GameState.speedY * delta

	if global_position.y > 750:
		GameState.totalEnemies -= 1
		if GameState.totalEnemies <= 0:
			GameState.totalEnemies = 0
			mainScene.startPreparationTimer()
		call_deferred("queue_free")
