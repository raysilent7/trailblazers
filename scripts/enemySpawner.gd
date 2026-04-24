extends Node

@onready var spawnTimer: Timer = $"../spawnTimer"
var enemyScene: PackedScene = preload("res://scenes/enemy.tscn")

var maxEnemies: int = 10
var maxWaves: int = 3
var waveCounter: int = 0

func onPreparationTimerTimeout() -> void:
	spawnTimer.start()

func onSpawnTimerTimeout() -> void:
	waveCounter += 1
	for count in range(maxEnemies):
		var enemy = enemyScene.instantiate()
		enemy.global_position = Vector2(randi_range(200, 700), 0)
		get_tree().current_scene.add_child(enemy)
		if waveCounter == 3:
			spawnTimer.stop()
