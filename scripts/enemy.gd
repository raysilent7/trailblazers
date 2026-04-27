extends Area2D

var speedY: float = 50.0
var maxHits: int = 1
var hits: int = 0
var mainScene

func _ready() -> void:
	mainScene = get_tree().current_scene

func _process(delta: float) -> void:
	position.y += speedY * delta
	if position.y > 1400:
		GameState.totalEnemies -= 1
		if GameState.totalEnemies <= 0:
			GameState.totalEnemies = 0
			mainScene.startPreparationTimer()
		call_deferred("queue_free")

func onBodyEntered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.takeHit()
		takeHit()

func onAreaEntered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		takeHit()

func takeHit():
	hits += 1
	Audio.playEnemyHit()
	print("enemy hits: " + str(hits))
	if hits >= maxHits:
		GameState.totalEnemies -= 1
		print("inimigos restantes: " + str(GameState.totalEnemies))
		if GameState.totalEnemies <= 0:
			GameState.totalEnemies = 0
			mainScene.startPreparationTimer()
		call_deferred("queue_free")
