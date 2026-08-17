extends CharacterBody2D
#
#@onready var anim: AnimatedSprite2D = $shipAnimeSpr
#@onready var shield: Sprite2D = $shield
#@onready var hud: CanvasLayer = $"../../HUD"
#@onready var joystick: Node2D = $"../../HUD/joystick"
#
#
#
#
#var maxHits: int = 5
#var hits: int = 0
#var canShoot: bool = true
#var shooting: bool = false
#var destroyed: bool = false
#var speedLevel: int = 0
#var projectileLevel: int = 0
#var shieldLevel: int = 0
#
#
#
#
#
#
#
#
#
#func applyUpgrade(type: String):
	#Audio.playUpgrade()
	#match type:
		#"speed":
			#if speedLevel < 3:
				#speedLevel += 1
				#updateSpeed()
				#hud.updateSpeed(speedLevel)
		#"projectile":
			#if projectileLevel < 3:
				#projectileLevel += 1
				#updateProjectiles()
				#hud.updateProjectile(projectileLevel)
		#"shield":
			#if shieldLevel < 3:
				#shieldLevel += 1
				#updateShield()
				#hud.updateShield(shieldLevel)
#
#func updateSpeed():
	#currentSpeed = baseSpeed * (1.0 + speedLevel * 0.10)
#
#func updateProjectiles():
	#match projectileLevel:
		#0: currentProjectiles = 1
		#1: currentProjectiles = 2
		#2: currentProjectiles = 3
		#3: currentProjectiles = 4
#
#func updateShield():
	#shield.visible = true
	#currentShieldHits = shieldLevel
