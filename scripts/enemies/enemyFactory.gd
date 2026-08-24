class_name EnemyFactory extends Node

var upgradeScene: PackedScene = preload("res://scenes/objects/upgrade.tscn")

var spaceEntities: Dictionary = {
	Constants.PIXEL_HOLE: preload("uid://db0ihrparvaky"),
	Constants.STAR: preload("uid://bba3ks1e4gnqx"),
	Constants.ENEMY_ERRATIC: preload("uid://b05mgvaaebo3c"),
	Constants.ENEMY_ZIGZAG: preload("uid://cvc2bw2gydnrv"),
	Constants.ENEMY_CHARGER: preload("uid://ch8bl470wur27"),
	Constants.ENEMY_SHOOTER: preload("uid://bbliw10gqghga"),
	Constants.ENEMY_CHASER: preload("uid://48y4fy5d30qi")
}

func spawnEnemy(enemyType: String, position: Vector2, variant: String) -> Enemy:
	print("inimigo escolhido: " + enemyType)
	var scene
	scene = spaceEntities.get(enemyType)
	var enemy = scene.instantiate()
	enemy.enemyType = enemyType
	enemy.variant = variant
	enemy.global_position = position
	return enemy

func createRandomUpgrade(position: Vector2) -> Upgrade:
	var upgrade: Upgrade = upgradeScene.instantiate()
	upgrade.global_position = position
	return upgrade
