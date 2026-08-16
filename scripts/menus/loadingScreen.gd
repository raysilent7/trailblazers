extends CanvasLayer

@onready var animation: AnimationPlayer = $animation

signal loadingScreenReady

func _ready() -> void:
	await animation.animation_finished
	loadingScreenReady.emit()

func onProgressChanged(_newValue: float) -> void:
	pass

func onBasicLoadFinished() -> void:
	animation.play_backwards("transition")
	await animation.animation_finished
	queue_free()

func onLoadFinished() -> void:
	queue_free()
