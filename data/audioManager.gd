extends Node

@onready var shoot: AudioStreamPlayer2D = $shoot
@onready var player_hit: AudioStreamPlayer2D = $playerHit
@onready var explosion: AudioStreamPlayer2D = $explosion
@onready var shield_hit: AudioStreamPlayer2D = $shieldHit
@onready var upgrade: AudioStreamPlayer2D = $upgrade
@onready var enemy_hit: AudioStreamPlayer2D = $enemyHit
@onready var button_hover: AudioStreamPlayer2D = $buttonHover
@onready var button_pressed: AudioStreamPlayer2D = $buttonPressed
@onready var birds: AudioStreamPlayer2D = $birds
@onready var music_1: AudioStreamPlayer2D = $music1
@onready var music_2: AudioStreamPlayer2D = $music2
@onready var music_3: AudioStreamPlayer2D = $music3


var silenceMin: int = 20
var silenceMax: int = 30
var lastTrack = null
var playing: bool = false
var generalVol: float = 1.0
var musicVol: float = 1.0
var FXVol: float = 1.0
var muteMusic: bool = false
var muteFX: bool = false

func _ready() -> void:
	music_1.finished.connect(onTrackFinished)
	music_2.finished.connect(onTrackFinished)
	music_3.finished.connect(onTrackFinished)
	loadSettings()

func setGeneralVolume(value: float):
	generalVol = value
	updateVolumes()

func setMusicVolume(value: float):
	musicVol = value
	updateVolumes()

func setFXVolume(value: float):
	FXVol = value
	updateVolumes()

func setMuteMusic(value: bool):
	muteMusic = value
	updateVolumes()

func setMuteFX(value: bool):
	muteFX = value
	updateVolumes()

func updateVolumes():
	var music: Array = get_tree().get_nodes_in_group("music")
	var effects: Array = get_tree().get_nodes_in_group("effect")

	for m in music:
		m.volume_db = linear_to_db(generalVol * musicVol)
		if muteMusic:
			m.volume_db = linear_to_db(generalVol * 0)

	for e in effects:
		e.volume_db = linear_to_db(generalVol * FXVol)
		if muteFX:
			e.volume_db = linear_to_db(generalVol * 0)
	
	saveSettings()

func playShoot():
	shoot.play()

func playPlayerHit():
	player_hit.play()

func playShieldHit():
	shield_hit.play()

func playUpgrade():
	upgrade.play()

func playEnemyHit():
	enemy_hit.play()

func playButtonHover():
	button_hover.play()

func playButtonPress():
	button_pressed.play()

func playExplosion():
	explosion.play()

func playBirds():
	birds.play()

func stopBirds():
	birds.stop()

func startMusicSystem():
	if not playing:
		playing = true
		playRandomTrack()

func stopMusicSystem():
	playing = false
	lastTrack.stop()

func playRandomTrack():
	var tracks = [music_1, music_2, music_3]
	var available = tracks.duplicate()
	if lastTrack != null:
		available.erase(lastTrack)

	var track = available.pick_random()
	lastTrack = track

	track.play()

func onTrackFinished():
	if not playing:
		return

	var waitTime = randf_range(silenceMin, silenceMax)
	await get_tree().create_timer(waitTime).timeout

	if playing:
		playRandomTrack()

func saveSettings():
	var data: Dictionary = {
		"generalVol": generalVol,
		"musicVol": musicVol,
		"FXVol": FXVol,
		"muteMusic": muteMusic,
		"muteFX": muteFX
	}
	var file: FileAccess = FileAccess.open("user://settings.save", FileAccess.WRITE)
	file.store_var(data)

func loadSettings():
	if not FileAccess.file_exists("user://settings.save"):
		return
	var file: FileAccess = FileAccess.open("user://settings.save", FileAccess.READ)
	var data: Dictionary = file.get_var()
	generalVol = data["generalVol"]
	musicVol = data["musicVol"]
	FXVol = data["FXVol"]
	muteMusic = data["muteMusic"]
	muteFX = data["muteFX"]
	updateVolumes()
