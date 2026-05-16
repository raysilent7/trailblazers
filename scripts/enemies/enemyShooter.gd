extends "res://scripts/enemies/enemy.gd"

var bulletScene: PackedScene = preload("res://scenes/objects/bullet.tscn")

var targetY: float
var moveSpeed: float = 80.0
var player: Node2D = null
var reachedTarget: bool = false

func _ready() -> void:
	targetY = [100.0, 150.0, 200.0, 250.0, 300.0, 350.0, 400.0].pick_random()
	super._ready()
	player = get_tree().current_scene.player
	$fireRate.start()

func _process(delta: float) -> void:
	if not reachedTarget:
		global_position.y += GameState.speedY * delta
		if global_position.y >= targetY:
			reachedTarget = true
	else:
		followPlayer(delta)

func followPlayer(delta: float):
	if player == null:
		return
	var dir: float = sign(player.global_position.x - global_position.x)
	global_position.x += dir * moveSpeed * delta

func onFireRateTimeout():
	shoot()

func shoot():
	Audio.playShoot()
	var bullet = bulletScene.instantiate()
	bullet.global_position = global_position
	get_tree().current_scene.add_child(bullet)

func choseVariant(variant: String) -> void:
	$enemySpr.play(variant)
