extends Control

@export var initialScene: StringName = &""
@onready var animation: AnimatedSprite2D = $animation

func _ready() -> void:
	Audio.playBirds()
	await animation.animation_finished
	changeScene()

func changeScene() -> void:
	Audio.stopBirds()
	SceneLoader.loadScene(initialScene, null)
