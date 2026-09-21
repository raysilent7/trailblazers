extends "enemy.gd"

@onready var detection: Area2D = $playerDetection

func _ready() -> void:
	super()
	behaviour.enemy = self
	behaviour.resolveAnimation()
	detection.body_entered.connect(onPlayerDetected)

func _process(delta: float) -> void:
	super(delta)
	behaviour.chargerBehaviour(delta)

func onPlayerDetected(body: Node2D) -> void:
	if body is Player:
		behaviour.player = body
