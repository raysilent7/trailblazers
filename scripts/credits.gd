extends Control

@onready var back: TextureButton = $back

func onBackPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func onBackMouseEntered() -> void:
	Audio.playButtonHover()
