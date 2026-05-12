extends Node

var waveConfig: WaveConfig
var enemyFactory: EnemyFactory
var waveTimer: Timer
var waveInterval: float = 20.0
var bossActive: bool = false
var distanceTraveled: float = 0.0
var maxTypes: int = 2
var lastType: String

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
	distanceTraveled = get_tree().current_scene.distanceTravelled
	if bossActive:
		return
	spawnWave()

func spawnWave():
	var count: int = waveConfig.getEnemyCount(distanceTraveled)
	var totalTypes: int = 0
	
	for i in count:
		var enemyType: String = waveConfig.getRandomEnemyType()
		var enemy: Node2D
		
		if not lastType:
			print("lastType: " + lastType)
			lastType = enemyType
			totalTypes += 1
		if enemyType != lastType:
			totalTypes += 1
		
		var pos: Vector2 = getRandomSpawnPosition()
		
		if totalTypes == maxTypes:
			enemy = enemyFactory.spawnEnemy(lastType, pos)
		else:
			enemy = enemyFactory.spawnEnemy(enemyType, pos)

		add_child(enemy)

func getRandomSpawnPosition() -> Vector2:
	var x: float = randi_range(20, 900)
	var y: float = randi_range(-40, -400)
	return Vector2(x, y)

func startBoss():
	bossActive = true

func endBoss():
	bossActive = false
