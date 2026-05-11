extends Node2D

var fog_color := Color(0.5, 0.2, 0.8, 0.4)

func _ready():
	$ColorRect.color = fog_color

func _on_area_entered(area):
	if area.is_in_group("player"):
		$ColorRect.visible = true

func _on_area_exited(area):
	if area.is_in_group("player"):
		$ColorRect.visible = false
