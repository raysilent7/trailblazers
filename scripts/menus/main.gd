extends Node2D

@onready var player: CharacterBody2D = $player/shipBody
@onready var cheats: Node2D = $cheats
@onready var HUDLayer: CanvasLayer = $HUD
@onready var joystick: Node2D = $HUD/joystick
var gameOverPopupScene: PackedScene = preload("res://scenes/menus/gameOverPopup.tscn")
var pausePopupScene: PackedScene = preload("res://scenes/menus/pauseMenu.tscn")

func _ready() -> void:
	Audio.startMusicSystem()
	cheats.visible = GameState.isDebugMode
	joystick.visible = GameState.isApkMode

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pauseMenu = pausePopupScene.instantiate()
		HUDLayer.add_child(pauseMenu)
		get_tree().paused = true

func onArmorCheatPressed() -> void:
	player.applyUpgrade("shield")

func onBulletCheatPressed() -> void:
	player.applyUpgrade("projectile")

func onSpeedCheatPressed() -> void:
	player.applyUpgrade("speed")

func onDistanceTravelledTimeout() -> void:
	GameState.distanceTraveled += 1
	GameState.speedY = min(GameState.speedY, 350) + 0.25
	HUDLayer.updateDistance(GameState.distanceTraveled)

func onInvinciblePressed() -> void:
	player.destroyed = not player.destroyed

func onSoundPressed() -> void:
	Audio.stopMusicSystem()

func showGameOverPopup():
	var popup = gameOverPopupScene.instantiate()
	HUDLayer.add_child(popup)
	popup.showPopup(GameState.distanceTraveled)

func onSummonStarPressed() -> void:
	$enemySpawner.summonStar()
