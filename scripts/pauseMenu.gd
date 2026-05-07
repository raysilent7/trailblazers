extends Control

@onready var generalVolSlider: HSlider = $menuBox/generalVolume
@onready var soundFXVolSlider: HSlider = $menuBox/soundFXVolume
@onready var musicVolSlider: HSlider = $menuBox/musicVolume
@onready var muteMusicCB: CheckBox = $menuBox/musicMute
@onready var muteSFXCB: CheckBox = $menuBox/soundFXMute

var mainScene

func _ready() -> void:
	generalVolSlider.value = Audio.generalVol
	musicVolSlider.value = Audio.musicVol
	soundFXVolSlider.value = Audio.FXVol
	muteMusicCB.button_pressed = Audio.muteMusic
	muteSFXCB.button_pressed = Audio.muteFX
	mainScene = get_tree().current_scene

func onContinuePressed() -> void:
	Audio.playButtonPress()
	get_tree().paused = false
	queue_free()

func onMainMenuPressed() -> void:
	PlayerData.addScore(mainScene.distanceTravelled)
	Audio.playButtonPress()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func onGeneralVolumeValueChanged(value: float) -> void:
	Audio.setGeneralVolume(value)

func onSoundFxVolumeValueChanged(value: float) -> void:
	Audio.setFXVolume(value)

func onMusicVolumeValueChanged(value: float) -> void:
	Audio.setMusicVolume(value)

func onSoundFxMuteToggled(toggledOn: bool) -> void:
	Audio.setMuteFX(toggledOn)

func onMusicMuteToggled(toggledOn: bool) -> void:
	Audio.setMuteMusic(toggledOn)

func onContinueMouseEntered() -> void:
	Audio.playButtonHover()

func onMainMenuMouseEntered() -> void:
	Audio.playButtonHover()
