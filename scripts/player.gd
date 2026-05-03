extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $shipAnimeSpr
@onready var shield: Sprite2D = $shield
@onready var hud: CanvasLayer = $"../../HUD"

var bulletScene: PackedScene = preload("res://scenes/bullet.tscn")
var baseSpeed: float = 300.0
var baseProjectiles: int = 1
var baseShieldHits: int = 0
var maxHits: int = 5
var hits: int = 0
var canShoot: bool = true
var shooting: bool = false
var destroyed: bool = false
var speedLevel: int = 0
var projectileLevel: int = 0
var shieldLevel: int = 0
var currentSpeed: float = baseSpeed
var currentProjectiles: int = baseProjectiles
var currentShieldHits: int = baseShieldHits

func _physics_process(_delta: float) -> void:
	if not destroyed:
		var inputVector = Input.get_vector("left", "right", "up", "down")
		velocity = inputVector * currentSpeed
		move_and_slide()
		clampToScreen()
		resolveAnimation(inputVector)

func resolveAnimation(inputVector):
	var baseAnim := "idle"
	var dmgSuffix := ""

	
	if inputVector.x > 0:
		baseAnim = "right"
	elif inputVector.x < 0:
		baseAnim = "left"

	if hits > 0 and inputVector.x == 0:
		dmgSuffix = str(hits) + "Dmg"
	elif hits > 0 and inputVector.x != 0:
		dmgSuffix = "Dmg"

	anim.play(baseAnim + dmgSuffix)

func _process(_delta: float) -> void:
	shooting = Input.is_action_pressed("shoot")

	if shooting and canShoot:
		shoot()
		start_fire_cooldown()

func clampToScreen():
	var viewport = get_viewport_rect()
	global_position.x = clamp(global_position.x, 16, viewport.size.x-16)
	global_position.y = clamp(global_position.y, 16, viewport.size.y-16)

func start_fire_cooldown():
	canShoot = false
	await get_tree().create_timer(0.5).timeout
	canShoot = true

func shoot():
	var spread = 20
	Audio.playShoot()

	for i in currentProjectiles:
		var offset = (i - (currentProjectiles - 1) / 2.0) * spread
		var b = bulletScene.instantiate()
		b.global_position = global_position + Vector2(offset, -20)
		get_tree().current_scene.add_child(b)

func takeHit():
	if currentShieldHits > 0:
		Audio.playShieldHit()
		currentShieldHits -= 1
		shieldLevel = currentShieldHits
		print("shield hits: " + str(currentShieldHits))
		hud.updateShield(shieldLevel+1)
		updateShieldVisual()
		return

	if not destroyed:
		hits += 1
		Audio.playPlayerHit()
		hud.updateHits(hits)
		print("player hits: " + str(hits))
		if hits >= maxHits:
			get_tree().paused = true
			destroyed = true
			Audio.playExplosion()
			anim.play("explosion")
			await get_tree().create_timer(2.0).timeout
			call_deferred("queue_free")
			get_tree().current_scene.showGameOverPopup()

func destroyShip():
	if not destroyed:
		get_tree().paused = true
		destroyed = true
		Audio.playExplosion()
		anim.play("explosion")
		await get_tree().create_timer(2.0).timeout
		call_deferred("queue_free")
		get_tree().current_scene.showGameOverPopup()

func updateShieldVisual():
	if currentShieldHits <= 0:
		shield.visible = false

func applyUpgrade(type: String):
	Audio.playUpgrade()
	match type:
		"speed":
			if speedLevel < 3:
				speedLevel += 1
				updateSpeed()
				hud.updateSpeed(speedLevel)
		"projectile":
			if projectileLevel < 3:
				projectileLevel += 1
				updateProjectiles()
				hud.updateProjectile(projectileLevel)
		"shield":
			if shieldLevel < 3:
				shieldLevel += 1
				updateShield()
				hud.updateShield(shieldLevel)

func updateSpeed():
	currentSpeed = baseSpeed * (1.0 + speedLevel * 0.10)

func updateProjectiles():
	match projectileLevel:
		0: currentProjectiles = 1
		1: currentProjectiles = 2
		2: currentProjectiles = 3
		3: currentProjectiles = 4

func updateShield():
	shield.visible = true
	currentShieldHits = shieldLevel
