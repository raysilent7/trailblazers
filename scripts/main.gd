extends Node2D

@onready var player: CharacterBody2D = $player/shipBody
@onready var cheat1: Button = $cheats/speedCheat
@onready var cheat2: Button = $cheats/bulletCheat
@onready var cheat3: Button = $cheats/armorCheat
@onready var preparationTimer: Timer = $preparationTimer
@onready var HUDLayer: CanvasLayer = $HUD
var upgradeScene: PackedScene = preload("res://scenes/upgrade.tscn")
var gameOverPopupScene: PackedScene = preload("res://scenes/gameOverPopup.tscn")

var distanceTravelled: int

func _ready() -> void:
	Audio.startMusicSystem()

func onArmorCheatPressed() -> void:
	player.applyUpgrade("shield")

func onBulletCheatPressed() -> void:
	player.applyUpgrade("projectile")

func onSpeedCheatPressed() -> void:
	player.applyUpgrade("speed")

func onDistanceTravelledTimeout() -> void:
	distanceTravelled += 1
	GameState.speedY = min(GameState.speedY, 600) + 0.5
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
