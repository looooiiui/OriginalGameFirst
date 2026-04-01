extends Node2D

@export var Touch : GPUParticles2D
@export var Display : Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Display.start()
	Touch.restart()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Display.is_stopped():
		queue_free()

func get_GlobalPosition(GlobalPosition : Vector2):
	global_position = GlobalPosition
