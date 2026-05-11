extends Node

var playerName: String = ""
var playerId: String = ""
var firstNameChange: bool = true
var highestScore: int = 0
var scoreBoard: Array[int] = []
var googleLinked: bool = false
var googleAccountId: String = ""

func _ready():
	loadData()
	if playerId == "":
		generateNewPlayer()

func generateNewPlayer():
	playerId = str(randi()) + str(Time.get_ticks_msec())
	playerName = "Player" + playerId
	firstNameChange = true
	highestScore = 0
	scoreBoard = []
	saveData()

func setPlayerName(newName: String):
	if firstNameChange:
		playerName = newName
		firstNameChange = false
		saveData()

func addScore(score: int):
	if score > highestScore:
		highestScore = score
	scoreBoard.append(score)
	scoreBoard.sort()
	scoreBoard.reverse()
	if scoreBoard.size() > 15:
		scoreBoard.resize(15)
	saveData()

func saveData():
	var data: Dictionary = {
		"playerName": playerName,
		"playerId": playerId,
		"firstNameChange": firstNameChange,
		"highestScore": highestScore,
		"scoreBoard": scoreBoard,
		"googleLinked": googleLinked,
		"googleAccountId": googleAccountId
	}
	var file: FileAccess = FileAccess.open("user://player.save", FileAccess.WRITE)
	file.store_var(data)

func loadData():
	if not FileAccess.file_exists("user://player.save"):
		return
	var file: FileAccess = FileAccess.open("user://player.save", FileAccess.READ)
	var data: Dictionary = file.get_var()
	playerName = data.get("playerName", "Player")
	playerId = data.get("playerId", "")
	firstNameChange = data.get("firstNameChange", true)
	highestScore = data.get("highestScore", 0)
	scoreBoard = data.get("scoreBoard", [])
	googleLinked = data.get("googleLinked", false)
	googleAccountId = data.get("googleAccountId", "")
