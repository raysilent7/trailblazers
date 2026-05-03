extends Node

@onready var preparationTimer: Timer = $"../preparationTimer"

var spaceEntities: Dictionary = {
	"nebula": preload("res://scenes/nebula.tscn"),
	"pixelHole": preload("res://scenes/blackHole.tscn"),
	"star": preload("res://scenes/star.tscn"),
	"erratic": preload("res://scenes/enemyErratic.tscn"),
	"zigZag": preload("res://scenes/enemyZigZag.tscn"),
	"charger": preload("res://scenes/enemyCharger.tscn")
}

var waveCounter: int = 0
var actualWave: Dictionary

func onPreparationTimerTimeout() -> void:
	print("timer iniciado: " + str(GameState.actualWave))
	actualWave = GameState.waves.get(GameState.actualWave)
	
	summonEnemies()
	
	if GameState.actualWave % 3 == 0:
		get_tree().current_scene.createRandomUpgrade()
	
	GameState.totalWaves += 1
	GameState.actualWave += 1
	
	if GameState.actualWave == 20:
		GameState.actualWave = 1

func summonEnemies() -> void:
	for count in range(actualWave.get("qty")):
		GameState.totalEnemies += 1
		var entityScene = spaceEntities.get(actualWave.get("entity"))
		var entity = entityScene.instantiate()
		resolveSpawnPosition(entity)
		get_tree().current_scene.get_node("enemySpawner").add_child(entity)

func resolveSpawnPosition(entity):
	if entity.is_in_group("enemy"):
		entity.global_position = Vector2(randi_range(20, 900), randi_range(-40, -400))
	else:
		entity.global_position = Vector2(randi_range(20, 900), -180)
