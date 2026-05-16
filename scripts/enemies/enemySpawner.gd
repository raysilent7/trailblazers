extends Node

var upgradeScene: PackedScene = preload("res://scenes/objects/upgrade.tscn")

var waveConfig: WaveConfig
var enemyFactory: EnemyFactory
var waveTimer: Timer
var waveInterval: float = 18.0
var bossActive: bool = false
var maxTypes: int = 2
var totalWaves: int = 0
var types: Array

func _ready():
	waveConfig = WaveConfig.new()
	enemyFactory = EnemyFactory.new()
	add_child(enemyFactory)
	waveTimer = Timer.new()
	waveTimer.wait_time = waveInterval
	waveTimer.timeout.connect(onWaveTimer)
	add_child(waveTimer)
	waveTimer.start()
	spawnWave()

func onWaveTimer():
	if bossActive:
		return
	types.clear()
	spawnWave()

func spawnWave():
	totalWaves += 1
	var count: int = waveConfig.getEnemyCount(GameState.distanceTraveled)
	
	if totalWaves % 3 == 0:
		createRandomUpgrade()
	
	if totalWaves % 5 == 0:
		add_child(enemyFactory.spawnEnemy(waveConfig.getRandomObject(), getRandomSpawnPosition()))
	
	for i in count:
		if types.size() < maxTypes:
			types.append(waveConfig.getRandomEnemyType())
		var chosenType:String = types.pick_random()
		var pos: Vector2 = getRandomSpawnPosition()
		var variant: String = waveConfig.getRandomVariant()
		var enemy: Node2D = enemyFactory.spawnEnemy(chosenType, pos)
		enemy.get_child(0).choseVariant(variant)
		add_child(enemy)

func getRandomSpawnPosition() -> Vector2:
	var x: float = randi_range(20, 900)
	var y: float = randi_range(-40, -400)
	return Vector2(x, y)

func startBoss():
	bossActive = true

func endBoss():
	bossActive = false

func createRandomUpgrade() -> void:
	var upgrade = upgradeScene.instantiate()
	upgrade.global_position = Vector2(randi_range(50, 900), 0)
	get_tree().current_scene.add_child(upgrade)

func summonStar() -> void:
	add_child(enemyFactory.spawnEnemy("star", getRandomSpawnPosition()))
