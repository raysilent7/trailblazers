extends Node2D

var gravityForce := 400.0
var speed: float = 50.0
var mainScene

func _ready() -> void:
	mainScene = get_tree().current_scene

func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > 1400:
		GameState.totalEnemies -= 1
		if GameState.totalEnemies <= 0:
			GameState.totalEnemies = 0
			mainScene.startPreparationTimer()
		print("pixel hole morreu")
		call_deferred("free")

func _physics_process(delta):
	var player = get_tree().current_scene.player
	if player == null:
		return

	var dist = global_position.distance_to(player.global_position)

	var gravityRadius = 600.0
	if dist < gravityRadius:
		var direction = (global_position - player.global_position).normalized()
		var force = gravityForce * (1.0 - dist / gravityRadius)
		player.global_position += direction * force * delta

func onSingularityBodyEntered(body: Node2D) -> void:
	print("aconteci")
	body.destroyShip()
