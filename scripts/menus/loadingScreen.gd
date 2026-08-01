extends CanvasLayer

@onready var animation: AnimationPlayer = $animation
@onready var panel: Panel = $panel

signal loadingScreenReady

func _ready() -> void:
	await animation.animation_finished
	loadingScreenReady.emit()

func onProgressChanged(newValue: float) -> void:
	pass

func onLoadFinished() -> void:
	animation.play_backwards("transition")
	await animation.animation_finished
	queue_free()
