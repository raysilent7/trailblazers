class_name WaveConfig extends Resource

var minEnemies: int = 10
var maxEnemies: int = 80
var distanceScale: float = 0.2
var maxTypes: int = 2

var enemyWeights: Dictionary = {
	Constants.ENEMY_ZIGZAG: 40,
	Constants.ENEMY_CHARGER: 25,
	Constants.ENEMY_ERRATIC: 15,
	Constants.ENEMY_SHOOTER: 10,
	Constants.ENEMY_CHASER: 10
}

var objectWeights: Dictionary = {
	Constants.PIXEL_HOLE: 40,
	Constants.STAR: 60
}

var variantWeights: Dictionary = {
	Constants.VARIANT_BASIC: 90,
	Constants.VARIANT_STALKER: 10
	}

func getEnemyCount(distance: float) -> int:
	var scaled: int = minEnemies + int(distance * distanceScale)
	return clamp(scaled, minEnemies, maxEnemies)

func getRandomEnemyTypes() -> Dictionary:
	var total: int = 0
	var acc: int = 0

	for weight in enemyWeights.values():
		total += weight

	var ratio: int = randi() % total

	for key in enemyWeights.keys():
		acc += enemyWeights[key]
		if ratio < acc:
			print("tipo retornado: " + key)
			return {key: enemyWeights[key]}
	return {Constants.ENEMY_ZIGZAG: 40}

func getRandomObject() -> String:
	var total: int = 0
	var acc: int = 0

	for weight in objectWeights.values():
		total += weight

	var ratio: int = randi() % total

	for key in objectWeights.keys():
		acc += objectWeights[key]
		if ratio < acc:
			print("tipo retornado: " + key)
			return key
	return Constants.STAR

func getRandomVariant() -> String:
	var total: int = 0
	var acc: int = 0

	for weight in variantWeights.values():
		total += weight

	var ratio: int = randi() % total

	for key in variantWeights.keys():
		acc += variantWeights[key]
		if ratio < acc:
			print("variante retornada: " + key)
			return key
	return Constants.VARIANT_BASIC
