extends Control

@onready var animation: AnimatedSprite2D = $animation

func _ready() -> void:
	Audio.playBirds()
	await animation.animation_finished.connect(changeScene)

func changeScene() -> void:
	Audio.stopBirds()
	get_tree().change_scene_to_file("res://scenes/menus/menu.tscn")
