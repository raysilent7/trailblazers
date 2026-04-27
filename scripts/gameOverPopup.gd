extends Control

func showPopup(distance):
	Audio.StopMusicSystem()
	$popupBox/message.text = "Sua nave foi destruída.\nSua jornada pelo universo termina aqui."
	$popupBox/distance.text = "Você percorreu %s UA." % distance
	visible = true

func onOkPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func onOkMouseEntered() -> void:
	Audio.playButtonHover()
