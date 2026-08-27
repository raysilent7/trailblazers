extends Area2D

@onready var tick: Timer = $damageTick

var speed: float = 50.0
var player: Player
var insideRadius: bool = false
var enemyType: String
var variant: String

func _ready() -> void:
	body_entered.connect(onBodyEntered)
	body_exited.connect(onBodyExited)
	tick.timeout.connect(accumulateHeatDamage)

func _process(delta: float) -> void:
	position.y += speed * delta
	
	if global_position.y > 860:
		print("solzinho morreu")
		call_deferred("queue_free")

func accumulateHeatDamage() -> void:
	if insideRadius:
		player.heatDamage += 0.0025
		if player.hp.heatDamage >= 1.0:
			player.hp.damage(1)
			player.hp.heatDamage = 0.0

func onBodyEntered(body: Node2D) -> void:
	if body is Player:
		insideRadius = true
		player = body

func onBodyExited(body: Node2D) -> void:
	if body is Player:
		insideRadius = false
		player = null
