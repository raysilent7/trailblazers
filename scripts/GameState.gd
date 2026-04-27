extends Node

var totalEnemies: int
var totalWaves: int
var actualWave: int = 0 #padrao 0

#Waves config
var waves = [
	{
		"qty": 10,
		"entity": "basic"
	},
	{
		"qty": 15,
		"entity": "basic"
	},
	{
		"qty": 1,
		"entity": "star"
	},
	{
		"qty": 1,
		"entity": "pixelHole"
	}
]
