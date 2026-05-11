extends Node

@onready var start: Button = $buttons/start
@onready var credits: Button = $buttons/credits
@onready var options: Button = $buttons/options

func _ready() -> void:
	restartGameState()
	get_tree().paused = false
	Audio.startMusicSystem()

func onCreditsPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/menus/credits.tscn")

func onCreditsMouseEntered() -> void:
	Audio.playButtonHover()

func onOptionsPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/menus/optionsMenu.tscn")

func onOptionsMouseEntered() -> void:
	Audio.playButtonHover()

func onStartPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/objects/main.tscn")

func onStartMouseEntered() -> void:
	Audio.playButtonHover()

func onScorePressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/menus/scoreBoard.tscn")

func onScoreMouseEntered() -> void:
	Audio.playButtonHover()

func restartGameState():
	GameState.actualWave = 1
	GameState.totalEnemies = 0
	GameState.totalWaves = 0
	GameState.speedY = 50.0
