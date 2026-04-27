extends Node

@onready var preparationTimer: Timer = $"../preparationTimer"

var spaceEntities: Dictionary = {
	"basic": preload("res://scenes/enemy.tscn"),
	"nebula": preload("res://scenes/nebula.tscn"),
	"pixelHole": preload("res://scenes/blackHole.tscn"),
	"star": preload("res://scenes/star.tscn")
}

var waveCounter: int = 0
var actualWave: Dictionary

func onPreparationTimerTimeout() -> void:
	actualWave = GameState.waves[GameState.actualWave]
	summonEnemies()
	GameState.totalWaves += 1
	GameState.actualWave += 1
	if GameState.actualWave == 3:
		get_tree().current_scene.createRandomUpgrade()
		GameState.actualWave = 0

func summonEnemies() -> void:
	for count in range(actualWave.get("qty")):
		GameState.totalEnemies += 1
		var entityScene = spaceEntities.get(actualWave.get("entity"))
		var entity = entityScene.instantiate()
		entity.global_position = Vector2(randi_range(50, 900), -500)
		get_tree().current_scene.get_node("enemySpawner").add_child(entity)
