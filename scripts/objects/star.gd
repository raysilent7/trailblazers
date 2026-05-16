extends Area2D

var speed: float = 50.0
var player: CharacterBody2D
var insideRadius: bool = false

func _process(delta: float) -> void:
	position.y += speed * delta

	if insideRadius:
		print("aconteceu 1")
		player.heatDamage += 0.0025
		if player.heatDamage >= 1.0:
			print("aconteceu 2")
			player.takeHit()
			player.heatDamage = 0.0
	
	if global_position.y > 860:
		print("solzinho morreu")
		call_deferred("queue_free")

func onBodyEntered(body: Node2D) -> void:
	insideRadius = true
	player = body

func onBodyExited(_body: Node2D) -> void:
	insideRadius = false
