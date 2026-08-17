extends Node2D

@onready var player: Player = $Player
@onready var cheats: Node2D = $cheats
@onready var HUDLayer: CanvasLayer = $HUD
@onready var joystick: Node2D = $HUD/joystick
var gameOverPopupScene: PackedScene = preload("res://scenes/menus/gameOverPopup.tscn")
var pausePopupScene: PackedScene = preload("res://scenes/menus/pauseMenu.tscn")

func _ready() -> void:
	Audio.startMusicSystem()
	cheats.visible = GameState.isDebugMode
	joystick.visible = GameState.isApkMode
	player.shipDestroyed.connect(showGameOverPopup)
	player.hp.immune = true
	var tween = create_tween()
	tween.tween_property(player, "position", Vector2(player.global_position.x, player.global_position.y-100.0), 1.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func(): player.hp.immune = false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pauseMenu = pausePopupScene.instantiate()
		HUDLayer.add_child(pauseMenu)
		get_tree().paused = true

func onDistanceTravelledTimeout() -> void:
	GameState.distanceTraveled += 1
	GameState.speedY = min(GameState.speedY, 350) + 0.25
	HUDLayer.updateDistance(GameState.distanceTraveled)

func onSoundPressed() -> void:
	Audio.stopMusicSystem()

func showGameOverPopup() -> void:
	var popup = gameOverPopupScene.instantiate()
	HUDLayer.add_child(popup)
	popup.showPopup(GameState.distanceTraveled)

#CHEAT BUTTONS
func onSummonStarPressed() -> void:
	$enemySpawner.summonStar()

func onInvinciblePressed() -> void:
	player.hp.immune = not player.hp.immune

func onArmorCheatPressed() -> void:
	player.applyUpgrade("shield")

func onBulletCheatPressed() -> void:
	player.applyUpgrade("projectile")

func onSpeedCheatPressed() -> void:
	player.applyUpgrade("speed")
