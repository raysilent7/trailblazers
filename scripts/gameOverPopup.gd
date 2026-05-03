extends Control

func showPopup(distance):
	Audio.stopMusicSystem()
	$popupBox/message.text = "Your ship was destroyed.\nYour journey ends here."
	$popupBox/distance.text = "You explored %s AU." % distance
	visible = true

func onOkPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func onOkMouseEntered() -> void:
	Audio.playButtonHover()
