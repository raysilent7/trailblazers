class_name HealthComponent extends Node

@export var maxHp: int = 5
@export var maxShieldHits: int = 3
var hp: int = 0
var immune: bool = false
var shieldHits: int
var heatDamage: float

signal healthChanged(emitter: Node2D, current: int, max: int)
signal shieldChanged(current: int, max: int)
signal died

func initialize() -> void:
	hp = maxHp
	shieldHits = 0

func damage(amount: int) -> void:
	if not immune:
		if shieldHits > 0:
			Audio.playShieldHit()
			shieldHits = clamp(shieldHits - 1, 0, maxShieldHits)
			shieldChanged.emit(shieldHits, maxShieldHits)
			print("shield hits: " + str(shieldHits))
			return
		
		hp = clamp(hp - amount, 0, maxHp)
		ping()
		Audio.playPlayerHit()
		print("player hits: " + str(hp))
		if hp == 0:
			immune = true
			died.emit()

func heal(amount: int) -> void:
	hp = clamp(hp + amount, 0, maxHp)
	ping()

func ping() -> void:
	healthChanged.emit(get_parent(), hp, maxHp)

func hpReset() -> void:
	hp = maxHp
	ping()
