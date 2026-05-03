extends Node

var silenceMin: int = 20
var silenceMax: int = 30
var lastTrack = null
var playing: bool = false

func _ready():
	$music1.finished.connect(onTrackFinished)
	$music2.finished.connect(onTrackFinished)
	$music3.finished.connect(onTrackFinished)

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
