class_name Enemy extends Area2D

@onready var collision: CollisionShape2D = $enemyCollision
@onready var hp: HealthComponent = $HealthComponent
@onready var behaviour: BehaviourComponent = $BehaviourComponent
@onready var animation: AnimatedSprite2D = $enemySpr
@onready var fireRate: Timer = $fireRate

var bulletScene: PackedScene = preload("uid://ccleuoi671i6b")
var enemyType: String
var variant: String

func _ready() -> void:
	area_entered.connect(onAreaEntered)
	body_entered.connect(onBodyEntered)
	hp.died.connect(died)
	fireRate.timeout.connect(shoot)
	setBehaviourAndVariant(enemyType, variant)

func _process(_delta: float) -> void:
	if global_position.y > 750:
		call_deferred("queue_free")

func onBodyEntered(body: Node2D) -> void:
	if body is Player:
		body.hp.damage(1)
		hp.damage(1)

func onAreaEntered(area: Area2D) -> void:
	if area.is_in_group("playerBullet"):
		hp.damage(1)

func died() -> void:
	call_deferred("queue_free")

func shoot():
	Audio.playShoot()
	var bullet = bulletScene.instantiate()
	bullet.global_position = global_position
	get_tree().current_scene.add_child(bullet)

func setBehaviourAndVariant(chosenType: String, chosenVariant: String) -> void:
	print(behaviour)
	behaviour.enemyType = chosenType
	behaviour.variant = chosenVariant
