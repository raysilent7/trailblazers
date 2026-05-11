extends Area2D

@onready var dmgTimer: Timer = $dmgTimer

var speed: float = 50.0
var player: CharacterBody2D
var insideRadius: bool = false
var mainScene

func _ready() -> void:
	mainScene = get_tree().current_scene

func _process(delta: float) -> void:
	position.y += speed * delta
	if global_position.y > 860:
		GameState.totalEnemies -= 1
		if GameState.totalEnemies <= 0:
			GameState.totalEnemies = 0
			mainScene.startPreparationTimer()
		print("solzinho morreu")
		call_deferred("free")

func onBodyEntered(body: Node2D) -> void:
	insideRadius = true
	player = body
	dmgTimer.start()

func onBodyExited(_body: Node2D) -> void:
	insideRadius = false
	dmgTimer.stop()

func onDmgTimerTimeout() -> void:
	player.takeHit()
