extends CanvasLayer

func updateHits(hits):
	var child = $hitsBox.get_children().get(hits)
	if child is TextureRect:
		child.visible = true

func updateSpeed(level):
	var child = $speedBox.get_children().get(level)
	if child is TextureRect:
		child.visible = true

func updateProjectile(level):
	var child = $projectileBox.get_children().get(level)
	if child is TextureRect:
		child.visible = true

func updateShield(level):
	var child = $shieldBox.get_children().get(level)
	if child is TextureRect:
		child.visible = not child.visible

func updateDistance(dist):
	$HBoxContainer/distance.text = str(int(dist)) + " AU"
