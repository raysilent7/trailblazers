extends Node

signal progressChanged(progress)
signal loadFinished

var loadingScreen: PackedScene = preload("uid://o4hu3m85igsi")
var loadedResource: PackedScene
var scenePath: String
var progress: Array = []
var useSubThreads: bool = true
var hasCustomLoading: bool = false

func _ready() -> void:
	set_process(false)

func loadScene(path: String, loading: PackedScene) -> void:
	scenePath = path
	var newLoadScreen
	
	if loading:
		hasCustomLoading = true
		newLoadScreen = loading.instantiate()
	else:
		newLoadScreen = loadingScreen.instantiate()
	 
	add_child(newLoadScreen)
	progressChanged.connect(newLoadScreen.onProgressChanged)
	
	if hasCustomLoading:
		loadFinished.connect(newLoadScreen.onLoadFinished)
	else:
		loadFinished.connect(newLoadScreen.onBasicLoadFinished)
	
	await newLoadScreen.loadingScreenReady
	
	startLoad()

func startLoad() -> void:
	var state = ResourceLoader.load_threaded_request(scenePath, "", useSubThreads)
	if state == OK:
		set_process(true)

func _process(_delta: float) -> void:
	var loadStatus = ResourceLoader.load_threaded_get_status(scenePath, progress)
	progressChanged.emit(progress[0])
	match loadStatus:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loadedResource = ResourceLoader.load_threaded_get(scenePath)
			get_tree().change_scene_to_packed(loadedResource)
			loadFinished.emit()
