extends "enemy.gd"

func _ready() -> void:
	super()
	behaviour.enemy = self
	behaviour.resolveAnimation()

func _process(delta: float) -> void:
	super(delta)
	behaviour.erraticBehaviour(delta)
