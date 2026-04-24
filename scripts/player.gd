extends CharacterBody2D

var bulletScene: PackedScene = preload("res://scenes/bullet.tscn")
var speed: float = 300.0
var maxHits: int = 5
var hits: int = 0
var canShoot: bool = true
var shooting: bool = false

func _physics_process(_delta: float) -> void:
	var inputVector = Input.get_vector("left", "right", "up", "down")
	velocity = inputVector * speed
	move_and_slide()

func _process(_delta: float) -> void:
	shooting = Input.is_action_pressed("shoot")

	if shooting and canShoot:
		shoot()
		start_fire_cooldown()

func start_fire_cooldown():
	canShoot = false
	await get_tree().create_timer(0.5).timeout
	canShoot = true

func shoot():
	var b = bulletScene.instantiate()
	b.global_position = global_position + Vector2(0, -20)
	get_tree().current_scene.add_child(b)

func takeHit():
	hits += 1
	print("player hits: " + str(hits))
	if hits >= maxHits:
		queue_free() #TODO: substituir por game over depois
