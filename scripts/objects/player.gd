class_name Player extends CharacterBody2D

@onready var controls: InputComponent = $InputComponent
@onready var hp: HealthComponent = $HealthComponent
@onready var upgrades: UpgradeComponent = $UpgradeComponent
@onready var animation: AnimatedSprite2D = $shipAnimeSpr
@onready var shield: Sprite2D = $shield
@export var baseSpeed: float = 300.0
@export var baseProjectiles: int = 1

var bulletScene: PackedScene = preload("res://scenes/objects/playerBullet.tscn")
var canShoot: bool = true
var currentSpeed: float
var currentProjectiles: int

signal shipDestroyed

func _ready() -> void:
	hp.shieldChanged.connect(updateShieldVisual)
	hp.died.connect(destroyShip)
	hp.initialize()
	upgrades.upgradeAcquired.connect(updateShip)
	currentSpeed = baseSpeed
	currentProjectiles = baseProjectiles

func _physics_process(_delta: float) -> void:
	controls.readInputs()
	if controls.shoot:
		shoot()
		
	if not hp.immune:
		var direction = controls.direction
		velocity = direction * currentSpeed
		move_and_slide()
		clampToScreen()
		resolveAnimation(direction)

func clampToScreen() -> void:
	var viewport = get_viewport_rect()
	global_position.x = clamp(global_position.x, 16, viewport.size.x-16)
	global_position.y = clamp(global_position.y, 16, viewport.size.y-16)

func resolveAnimation(direction) -> void:
	var baseAnim := "idle"
	var dmgSuffix := ""

	if direction.x > 0:
		baseAnim = "right"
	elif direction.x < 0:
		baseAnim = "left"

	if hp.hp < 5 and direction.x == 0:
		dmgSuffix = str(hp.hp) + "Dmg"
	elif hp.hp < 5 and direction.x != 0:
		dmgSuffix = "Dmg"

	animation.play(baseAnim + dmgSuffix)

func shoot() -> void:
	if canShoot:
		startFireCooldown()
		var spread = 20
		Audio.playShoot()

		for i in currentProjectiles:
			var offset = (i - (currentProjectiles - 1) / 2.0) * spread
			var bullet = bulletScene.instantiate()
			bullet.global_position = global_position + Vector2(offset, -20)
			get_tree().current_scene.add_child(bullet)

func startFireCooldown() -> void:
	canShoot = false
	await get_tree().create_timer(0.5).timeout
	canShoot = true

func updateShieldVisual(current: int, _max: int) -> void:
	if current > 0:
		shield.visible = true
	else:
		shield.visible = false

func destroyShip():
	Audio.playExplosion()
	animation.play("explosion")
	await animation.animation_finished
	shipDestroyed.emit()
	call_deferred("queue_free")

func updateShip(type: String, currentLevel: int, _maxLevel: int) -> void:
	match type:
		UpgradeTypes.SPEED: updateSpeed(currentLevel)
		UpgradeTypes.SHIELD: updateShield(currentLevel)
		UpgradeTypes.WEAPON: updateProjectiles(currentLevel)
		UpgradeTypes.WARP: return

func updateSpeed(speedLevel: int):
	currentSpeed = baseSpeed * (1.0 + speedLevel * 0.10)
	print("velocidade: " + str(currentSpeed))

func updateProjectiles(currentLevel: int):
	match currentLevel:
		0: currentProjectiles = 1
		1: currentProjectiles = 2
		2: currentProjectiles = 3
		3: currentProjectiles = 4
	print("projeteis: " + str(currentProjectiles))

func updateShield(currentLevel: int):
	shield.visible = true
	hp.shieldHits = currentLevel
	print("shield: " + str(hp.shieldHits))
