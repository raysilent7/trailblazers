extends Node

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
	$music1.finished.connect(onTrackFinished)
	$music2.finished.connect(onTrackFinished)
	$music3.finished.connect(onTrackFinished)
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
	$shoot.play()

func playPlayerHit():
	$playerHit.play()

func playShieldHit():
	$shieldHit.play()

func playUpgrade():
	$upgrade.play()

func playEnemyHit():
	$enemyHit.play()

func playButtonHover():
	$buttonHover.play()

func playButtonPress():
	$buttonPressed.play()

func playExplosion():
	$explosion.play()

func playMusic1():
	$music1.play()

func playMusic2():
	$music2.play()

func playMusic3():
	$music3.play()

func startMusicSystem():
	if not playing:
		playing = true
		playRandomTrack()

func stopMusicSystem():
	playing = false
	lastTrack.stop()

func playRandomTrack():
	var tracks = [$music1, $music2, $music3]
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
