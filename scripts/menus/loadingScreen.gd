extends CanvasLayer

@export var animation: AnimationPlayer

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
	
