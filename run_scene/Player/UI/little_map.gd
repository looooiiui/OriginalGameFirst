extends SubViewport

@export var LittleCamera: Camera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world_2d = get_tree().root.world_2d


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_cameraFollow()

func _cameraFollow() -> void:
	LittleCamera.global_position = Player.instance.global_position
