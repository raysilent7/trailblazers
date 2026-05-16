extends "res://scripts/enemies/enemy.gd"

var moveSpeed: float = 110.0
var player: Node2D = null

func _ready() -> void:
	super._ready()
	player = mainScene.player

func _process(delta: float) -> void:
	if player == null:
		return
	var dir: Vector2 = (player.global_position - global_position).normalized()
	global_position += dir * moveSpeed * delta

func choseVariant(variant: String) -> void:
	$enemySpr.play(variant)
