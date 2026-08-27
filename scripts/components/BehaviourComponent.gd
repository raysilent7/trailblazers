class_name BehaviourComponent extends Node

var enemy: Enemy
var player: Player
var enemyType: String = SpaceEntities.ENEMY_ZIGZAG
var variant: String = SpaceEntities.VARIANT_BASIC
var state: String = "descending"
var direction: Vector2 = Vector2.ZERO
var timeToChange: float = 0.0
var targetY: float
var orientation: int = 0
var reachedTarget: bool = false
var time: float = 0.0
var amplitude: float = 200.0
var frequency: float = 3.0
var lateralSpeed: float = 600.0
var screenMargin: float = 10.0
var chargeSpeed: float = 700.0
var waitTime: float = 2.5

const SEPARATOR: String = "-"

func _ready() -> void:
	targetY = [100.0, 150.0, 200.0, 250.0, 300.0, 350.0, 400.0].pick_random()
	orientation = [-1, 1].pick_random()

func chargerBehaviour(delta: float) -> void:
	match state:
		"descending":
			enemy.global_position.y += GameState.speedY * delta
			if enemy.global_position.y >= targetY:
				state = "waiting"
				startWait()
		"charging":
			enemy.global_position += direction * chargeSpeed * delta

func startWait() -> void:
	await get_tree().create_timer(waitTime).timeout
	if player:
		direction = (player.global_position - enemy.global_position).normalized()
	state = "charging"

func chaserBehaviour(delta: float) -> void:
	if player == null:
		enemy.global_position.y += GameState.speedY * delta
		return

	var dir: Vector2 = (player.global_position - enemy.global_position).normalized()
	enemy.global_position += dir * GameState.speedY * delta

func erraticBehaviour(delta: float) -> void:
	var viewport = get_tree().current_scene.get_viewport_rect()
	timeToChange = clamp(timeToChange-delta, 0, 1.6)

	if timeToChange == 0:
		pickNewDirection()

	if enemy.global_position.x < screenMargin:
		orientation = 1
	elif enemy.global_position.x > viewport.size.x - screenMargin:
		orientation = -1

	enemy.global_position.x += orientation * lateralSpeed * delta
	enemy.global_position.y += GameState.speedY * delta

func pickNewDirection():
	orientation = randi_range(-1, 1)
	timeToChange = randf_range(1.0, 1.6)

func shooterBehaviour(delta: float) -> void:
	if not reachedTarget:
		enemy.global_position.y += GameState.speedY * delta
		if enemy.global_position.y >= targetY:
			reachedTarget = true
	else:
		followPlayer(delta)

func followPlayer(delta: float):
	if player == null:
		return
	var dir: float = sign(player.global_position.x - enemy.global_position.x)
	enemy.global_position.x += dir * GameState.speedY * delta

func zigzagBehaviour(delta: float) -> void:
	time += delta
	enemy.global_position.x += sin(time * frequency) * amplitude * delta * orientation
	enemy.global_position.y += GameState.speedY * delta

func resolveAnimation() -> void:
	enemy.animation.play(variant+SEPARATOR+enemyType)
