extends Node

func onStartPressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func onCreditsPressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
