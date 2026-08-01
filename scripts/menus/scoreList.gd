extends CanvasLayer

@export var font: FontFile = preload("res://assets/others/font.ttf")
@onready var scoreList: VBoxContainer = $scoreRoot/box/scoreList

func _ready() -> void:
	updateList()

func updateList():
	for child in scoreList.get_children():
		child.queue_free()

	var fontColor: Color = Color(1.0, 0.835, 0.255)

	for score in PlayerData.scoreBoard:
		var label: Label = Label.new()
		label.text = str(score) + " light years"
		label.add_theme_font_override("font", font)
		label.add_theme_color_override("font_color", fontColor)
		label.add_theme_font_size_override("font_size", 14)
		scoreList.add_child(label)

func onBackPressed() -> void:
	Audio.playButtonPress()
	get_tree().change_scene_to_file("res://scenes/menus/menu.tscn")

func onBackMouseEntered() -> void:
	Audio.playButtonHover()
