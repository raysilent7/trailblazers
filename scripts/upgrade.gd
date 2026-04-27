extends Area2D

@onready var sprite: Sprite2D = $upgradeSpr

var textureNames: Array = ["speed", "shield", "projectile"]
var textures: Dictionary = {
	"speed": preload("res://assets/images/speed upgrade.png"),
	"shield": preload("res://assets/images/armor upgrade.png"),
	"projectile": preload("res://assets/images/bullet upgrade.png")
}
var chosenUpgrade: String
var speed: float = 50.0

func _ready() -> void:
	chosenUpgrade = textureNames[randi() % textureNames.size()]
	sprite.texture = textures.get(chosenUpgrade)

func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > 800:
		queue_free()

func onBodyEntered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.applyUpgrade(chosenUpgrade)
		queue_free()
