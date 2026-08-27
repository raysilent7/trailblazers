class_name EnemyFactory extends Node

var upgradeScene: PackedScene = preload("res://scenes/objects/upgrade.tscn")

var spaceEntities: Dictionary = {
	SpaceEntities.PIXEL_HOLE: preload("uid://db0ihrparvaky"),
	SpaceEntities.STAR: preload("uid://bba3ks1e4gnqx"),
	SpaceEntities.ENEMY_ERRATIC: preload("uid://b05mgvaaebo3c"),
	SpaceEntities.ENEMY_ZIGZAG: preload("uid://cvc2bw2gydnrv"),
	SpaceEntities.ENEMY_CHARGER: preload("uid://ch8bl470wur27"),
	SpaceEntities.ENEMY_SHOOTER: preload("uid://bbliw10gqghga"),
	SpaceEntities.ENEMY_CHASER: preload("uid://48y4fy5d30qi")
}

func spawnEnemy(enemyType: String, position: Vector2, variant: String) -> Area2D:
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
