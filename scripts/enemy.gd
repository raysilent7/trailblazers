extends Area2D

var speed: float = 50.0
var maxHits: int = 1
var hits: int = 0

func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > 800:
		queue_free()

func onBodyEntered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.takeHit()

func onAreaEntered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		takeHit()
		await get_tree().create_timer(4.0).timeout

func takeHit():
	hits += 1
	print("enemy hits: " + str(hits))
	if hits >= maxHits:
		queue_free()
