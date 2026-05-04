extends Node

@onready var start: TextureButton = $buttons/start
@onready var credits: TextureButton = $buttons/credits

func _ready() -> void:
	GameState.actualWave = 1
	GameState.totalEnemies = 0
	GameState.totalWaves = 0
	get_tree().paused = false
	Audio.startMusicSystem()
	start.visible = not GameState.isApkMode
	credits.visible = not GameState.isApkMode

func onStartPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func onCreditsPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

func onStartMouseEntered() -> void:
	Audio.playButtonHover()

func onCreditsMouseEntered() -> void:
	Audio.playButtonHover()

func onStartTouchPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func onCreditsTouchPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
