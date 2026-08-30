class_name HUD extends CanvasLayer

@onready var hits: HBoxContainer = $hitsBox
@onready var shield: HBoxContainer = $shieldBox
@onready var speed: HBoxContainer = $speedBox
@onready var projectile: HBoxContainer = $projectileBox
@onready var distance: Label = $distanceBox/distance

func updateHits(emitter: Node2D, current: int, _maxValue:int):
	print("current hp: " + str(current))
	if emitter is Player:
		var child = hits.get_children().get(current)
		if child is TextureRect:
			child.visible = false

func receiveUpgradeInfo(type: String, current: int, _maxValue: int) -> void:
	match type:
		UpgradeTypes.SHIELD: updateShield(current)
		UpgradeTypes.SPEED: updateSpeed(current)
		UpgradeTypes.WEAPON: updateProjectile(current)

func updateSpeed(level):
	var child = speed.get_children().get(level)
	if child is TextureRect:
		child.visible = true

func updateProjectile(level):
	var child = projectile.get_children().get(level)
	if child is TextureRect:
		child.visible = true

func updateShield(level):
	var child = shield.get_children().get(level)
	if child is TextureRect:
		child.visible = not child.visible

func updateDistance(dist):
	distance.text = str(int(dist)) + " light years"
