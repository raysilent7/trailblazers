extends Node

var totalEnemies: int
var totalWaves: int
var actualWave: int = 1 #padrao 1
var speedY: float = 50.0

#Enemy types:
#nebula
#pixelHole
#star
#erratic
#zigZag
#charger

#Waves config
var waves: Dictionary = {
	1: {
		"qty": 20,
		"entity": "zigZag"
	},
	2: {
		"qty": 10,
		"entity": "charger"
	},
	3: {
		"qty": 25,
		"entity": "erratic"
	},
	4: {
		"qty": 15,
		"entity": "charger"
	},
	5: {
		"qty": 2,
		"entity": "star"
	},
	6: {
		"qty": 1,
		"entity": "pixelHole"
	},
	7: {
		"qty": 40,
		"entity": "erratic"
	},
	8: {
		"qty": 20,
		"entity": "charger"
	},
	9: {
		"qty": 50,
		"entity": "erratic"
	},
	10: {
		"qty": 50,
		"entity": "zigZag"
	},
	11: {
		"qty": 60,
		"entity": "zigZag"
	},
	12: {
		"qty": 1,
		"entity": "pixelHole"
	},
	13: {
		"qty": 1,
		"entity": "pixelHole"
	},
	14: {
		"qty": 1,
		"entity": "star"
	},
	15: {
		"qty": 30,
		"entity": "charger"
	},
	16: {
		"qty": 50,
		"entity": "erratic"
	},
	17: {
		"qty": 80,
		"entity": "zigZag"
	},
	18: {
		"qty": 2,
		"entity": "star"
	},
	19: {
		"qty": 2,
		"entity": "pixelHole"
	},
	20: {
		"qty": 50,
		"entity": "charger"
	}
}
