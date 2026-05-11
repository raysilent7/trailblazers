extends Control

func showPopup(distance):
	Audio.stopMusicSystem()
	$popupBox/message.text = "Your ship was destroyed.\nYour journey ends here."
	$popupBox/distance.text = "You explored %s light years." % distance
	PlayerData.addScore(distance)
	visible = true

func onOkPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/menus/menu.tscn")

func onOkMouseEntered() -> void:
	Audio.playButtonHover()
