class_name GCamera

extends Node2D


static var instance : GCamera
@export var Camera : Camera2D
@export var is_Smooth : bool = false
@export var smooth : float = 0.1
@export var target_Global_position : Vector2
@export var cameraDeadPull : Vector2 = Vector2(2, 2)
@export var cameraOriginalPull : Vector2 = Vector2(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GCamera.instance == null:
		GCamera.instance = self
	else:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if GameManager.instance.currentLevel == 0:
		global_position = Vector2(0, 0)
	elif GameManager.instance.currentLevel != 0 and !GameManager.instance.is_Game_Over:
		_track_Player(is_Smooth)
	
	
	if GameManager.instance.is_Game_Over:
		Camera.zoom = lerp(Camera.zoom, cameraDeadPull, 1)
	else:
		Camera.zoom = cameraOriginalPull

func _track_Player(is_Smooth : bool):
	target_Global_position = Player.instance.global_position
	if is_Smooth:
		global_position = lerp(global_position, target_Global_position, smooth)
	else:
		global_position = target_Global_position
	
