extends Node

func _ready() -> void:
	GameState.actualWave = 1
	GameState.totalEnemies = 0
	GameState.totalWaves = 0
	get_tree().paused = false
	Audio.startMusicSystem()

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
