extends Control

@onready var generalVolSlider: HSlider = $panel/generalVolume
@onready var soundFXVolSlider: HSlider = $panel/soundFXVolume
@onready var musicVolSlider: HSlider = $panel/musicVolume
@onready var muteMusicCB: CheckBox = $panel/musicMute
@onready var muteSFXCB: CheckBox = $panel/soundFXMute
var audioManager: Node2D = null

func _ready() -> void:
	generalVolSlider.value = Audio.generalVol
	musicVolSlider.value = Audio.musicVol
	soundFXVolSlider.value = Audio.FXVol
	muteMusicCB.button_pressed = Audio.muteMusic
	muteSFXCB.button_pressed = Audio.muteFX

func onBackPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/menus/menu.tscn")

func onBackMouseEntered() -> void:
	Audio.playButtonHover()

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
