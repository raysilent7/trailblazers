extends Area2D

var maxHits: int = 1
var hits: int = 0
var mainScene

func _ready() -> void:
	mainScene = get_tree().current_scene

func _process(delta: float) -> void:
	global_position.y += GameState.speedY * delta
	if global_position.y > 750:
		call_deferred("queue_free")

func onBodyEntered(body: Node2D) -> void:
	if body is Player:
		body.hp.damage(1)
		damage()

func onAreaEntered(area: Area2D) -> void:
	if area.is_in_group("playerBullet"):
		damage()

func damage():
	hits += 1
	Audio.playEnemyHit()
	print("enemy hits: " + str(hits))
	if hits >= maxHits:
		call_deferred("queue_free")
