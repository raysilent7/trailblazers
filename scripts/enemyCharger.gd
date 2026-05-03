extends "res://scripts/enemy.gd"

var stopY := 400.0
var waitTime := 2.5
var chargeSpeed := 700.0

var state := "descending"
var direction := Vector2.ZERO

func _process(delta):
	match state:
		"descending":
			position.y += GameState.speedY * delta
			if position.y >= stopY:
				state = "waiting"
				startWait()

		"charging":
			position += direction * chargeSpeed * delta

	if global_position.y > 750:
		GameState.totalEnemies -= 1
		if GameState.totalEnemies <= 0:
			GameState.totalEnemies = 0
			mainScene.startPreparationTimer()
		call_deferred("queue_free")

func startWait():
	await get_tree().create_timer(waitTime).timeout
	var player = get_tree().current_scene.player
	if player:
		direction = (player.global_position - global_position).normalized()
	state = "charging"
