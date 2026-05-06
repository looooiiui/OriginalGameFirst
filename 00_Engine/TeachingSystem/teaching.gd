extends Node2D
class_name TeachingSystem

static var mutex: Mutex = Mutex.new()
static var instance: TeachingSystem

var isTip: bool = false
var FirstSave: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_instance_initialize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _instance_initialize() -> void:
	if instance == null:
		mutex.lock()
		if instance == null:
			instance = self
		mutex.unlock()
	else:
		queue_free()
