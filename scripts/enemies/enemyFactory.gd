class_name EnemyFactory extends Node

var upgradeScene: PackedScene = preload("res://scenes/objects/upgrade.tscn")

var spaceEntities: Dictionary = {
	"pixelHole": preload("res://scenes/objects/blackHole.tscn"),
	"star": preload("res://scenes/objects/star.tscn"),
	"erratic": preload("res://scenes/enemies/enemyErratic.tscn"),
	"zigZag": preload("res://scenes/enemies/enemyZigZag.tscn"),
	"charger": preload("res://scenes/enemies/enemyCharger.tscn"),
	"shooter": preload("res://scenes/enemies/enemyShooter.tscn"),
	"chaser": preload("res://scenes/enemies/enemyChaser.tscn")
}

func spawnEnemy(enemyType: String, position: Vector2) -> Enemy:
	print("inimigo escolhido: " + enemyType)
	var scene = spaceEntities.get(enemyType)
	var enemy = scene.instantiate()
	enemy.global_position = position
	return enemy

func createRandomUpgrade(position: Vector2) -> Upgrade:
	var upgrade: Upgrade = upgradeScene.instantiate()
	upgrade.global_position = position
	return upgrade
