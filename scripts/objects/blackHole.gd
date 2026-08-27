extends Area2D

@onready var singularity: Area2D = $singularity

var gravityForce := 400.0
var speed: float = 50.0
var enemyType: String
var variant: String

func _ready() -> void:
	singularity.body_entered.connect(onSingularityBodyEntered)

func _process(delta: float) -> void:
	position.y += speed * delta
	if global_position.y > 880:
		call_deferred("queue_free")

func _physics_process(delta):
	var player = get_tree().current_scene.player
	if player == null:
		return

	var dist = global_position.distance_to(player.global_position)

	var gravityRadius = 600.0
	if dist < gravityRadius:
		var direction = (global_position - player.global_position).normalized()
		var force = gravityForce * (1.0 - dist / gravityRadius)
		player.global_position += direction * force * delta

func onSingularityBodyEntered(body: Node2D) -> void:
	if body is Player:
		body.destroyShip()
