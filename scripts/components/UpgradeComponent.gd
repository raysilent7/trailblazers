class_name UpgradeComponent extends Node

@export var maxSpeedLevel: int = 3
@export var maxShieldLevel: int = 3
@export var maxWeaponLevel: int = 3
@export var minSpeedLevel: int = 1
@export var minShieldLevel: int = 1
@export var minWeaponLevel: int = 1

var speedLevel: int = 0
var weaponLevel: int = 0
var shieldLevel: int = 0

signal upgradeAcquired(type: String, currentLevel: int, maxLevel: int)

func applyUpgrade(type: String):
	Audio.playUpgrade()
	match type:
		UpgradeTypes.SPEED:
			if speedLevel < maxSpeedLevel:
				speedLevel = clamp(speedLevel+1, 1, maxSpeedLevel)
				upgradeAcquired.emit(type, speedLevel, maxSpeedLevel)
		UpgradeTypes.WEAPON:
			if weaponLevel < maxWeaponLevel:
				weaponLevel = clamp(weaponLevel+1, 1, maxWeaponLevel)
				upgradeAcquired.emit(type, weaponLevel, maxWeaponLevel)
		UpgradeTypes.SHIELD:
			if shieldLevel < 3:
				shieldLevel = clamp(shieldLevel+1, 1, maxShieldLevel)
				upgradeAcquired.emit(type, shieldLevel, maxShieldLevel)
