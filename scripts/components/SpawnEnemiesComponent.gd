class_name Spawner extends Node

@export var maxTypes: int = 2
@export var waveInterval: float = 18.0
@export var bossActive: bool = false

var types: Dictionary
var totalWaves: int = 0
var waveConfig: WaveConfig
var enemyFactory: EnemyFactory

func _ready() -> void:
	waveConfig = WaveConfig.new()
	enemyFactory = EnemyFactory.new()
	var waveTimer = Timer.new()
	waveTimer.wait_time = waveInterval
	waveTimer.timeout.connect(onWaveTimer)
	add_child(waveTimer)
	waveTimer.start()
	await get_tree().create_timer(2.0).timeout
	spawnWave()

func onWaveTimer() -> void:
	if bossActive:
		return
	types.clear()
	spawnWave()

func spawnWave() -> void:
	print("wave: " + str(totalWaves))
	totalWaves += 1
	var count: int = waveConfig.getEnemyCount(GameState.distanceTraveled)
	
	if totalWaves % 3 == 0:
		add_child(enemyFactory.createRandomUpgrade(getRandomSpawnPosition()))
	
	if totalWaves % 5 == 0:
		add_child(enemyFactory.spawnEnemy(waveConfig.getRandomObject(), getRandomSpawnPosition(), ""))
	
	for i in count:
		if types.size() < maxTypes:
			print("types size: " + str(types.size()))
			types.merge(waveConfig.getRandomEnemyTypes())
		var enemy: Enemy = enemyFactory.spawnEnemy(chooseType(types), getRandomSpawnPosition(), waveConfig.getRandomVariant())
		add_child(enemy)

func chooseType(typesReturned: Dictionary) -> String:
	var highest: String = typesReturned.find_key(typesReturned.values().max())
	var total: int = 0
	var acc: int = 0
	
	for weight in typesReturned.values():
		total += weight

	var ratio: int = randi() % total

	for key in typesReturned.keys():
		acc += typesReturned[key]
		if ratio < acc:
			return key
	return highest

func getRandomSpawnPosition() -> Vector2:
	var x: float = randi_range(20, 900)
	var y: float = randi_range(-40, -400)
	return Vector2(x, y)

func startBoss() -> void:
	bossActive = true

func endBoss() -> void:
	bossActive = false

func summonStar() -> void:
	add_child(enemyFactory.spawnEnemy(SpaceEntities.STAR, getRandomSpawnPosition(), ""))
