extends Resource
class_name WaveConfig

var baseEnemies: int = 10
var maxEnemies: int = 80
var distanceScale: float = 0.2
var maxTypes: int = 2

var enemyWeights: Dictionary = {
	"zigZag": 40,
	"charger": 25,
	"erratic": 15,
	"shooter": 10,
	"chaser": 10
}

func getEnemyCount(distance: float) -> int:
	var scaled: int = baseEnemies + int(distance * distanceScale)
	return clamp(scaled, baseEnemies, maxEnemies)

func getRandomEnemyType() -> String:
	var total: int = 0
	var acc: int = 0

	for weight in enemyWeights.values():
		total += weight

	var ratio: int = randi() % total

	for key in enemyWeights.keys():
		acc += enemyWeights[key]
		if ratio < acc:
			print("tipo retornado: " + key)
			return key
	return "zigZag"
