extends Node2D

@onready var player: CharacterBody2D = $player/shipBody
@onready var cheats: Node2D = $cheats
@onready var preparationTimer: Timer = $preparationTimer
@onready var HUDLayer: CanvasLayer = $HUD
@onready var joystick: Node2D = $HUD/joystick
var upgradeScene: PackedScene = preload("res://scenes/objects/upgrade.tscn")
var gameOverPopupScene: PackedScene = preload("res://scenes/menus/gameOverPopup.tscn")
var pausePopupScene: PackedScene = preload("res://scenes/menus/pauseMenu.tscn")

var distanceTravelled: int

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
	distanceTravelled += 1
	GameState.speedY = min(GameState.speedY, 400) + 0.5
	HUDLayer.updateDistance(distanceTravelled)

func onInvinciblePressed() -> void:
	player.destroyed = not player.destroyed

func onSoundPressed() -> void:
	Audio.stopMusicSystem()

func createRandomUpgrade() -> void:
	var upgrade = upgradeScene.instantiate()
	upgrade.global_position = Vector2(randi_range(50, 900), 0)
	get_tree().current_scene.add_child(upgrade)

func startPreparationTimer():
	preparationTimer.start()

func showGameOverPopup():
	var popup = gameOverPopupScene.instantiate()
	HUDLayer.add_child(popup)
	popup.showPopup(distanceTravelled)
