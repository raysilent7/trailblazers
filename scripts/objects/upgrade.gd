class_name Upgrade extends Area2D

@onready var sprite: Sprite2D = $upgradeSpr

var upgradeWeights: Dictionary = {
	UpgradeTypes.SPEED: 35, 
	UpgradeTypes.WEAPON: 25, 
	UpgradeTypes.SHIELD: 30, 
	UpgradeTypes.WARP: 5
}

var textures: Dictionary = {
	UpgradeTypes.SPEED: preload("res://assets/images/speed upgrade.png"),
	UpgradeTypes.SHIELD: preload("res://assets/images/armor upgrade.png"),
	UpgradeTypes.WEAPON: preload("res://assets/images/bullet upgrade.png")
}

var chosenUpgrade: String
var speed: float = 50.0

func _ready() -> void:
	chosenUpgrade = getRandomUpgrade()
	sprite.texture = textures.get(chosenUpgrade)

func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > 800:
		queue_free()

func onBodyEntered(body: Node2D) -> void:
	if body is Player:
		print("upgrade aplicado: " + chosenUpgrade)
		body.upgrades.applyUpgrade(chosenUpgrade)
		queue_free()

func getRandomUpgrade() -> String:
	var total: int = 0
	var acc: int = 0

	for weight in upgradeWeights.values():
		total += weight

	var ratio: int = randi() % total

	for key in upgradeWeights.keys():
		acc += upgradeWeights[key]
		if ratio < acc:
			print("tipo retornado: " + key)
			return key
	return UpgradeTypes.SPEED
