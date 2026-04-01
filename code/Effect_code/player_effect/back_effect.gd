extends Node2D

@export var Play_Time : Timer
@export var Play_effect : GPUParticles2D
@export var offset : Vector2 = Vector2(0, 50)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Play_effect.restart()
	Play_Time.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = Player.instance.global_position + offset
	if Player.instance.playerToward == true:
		Play_effect.rotation = PI
	else:
		Play_effect.rotation = 0
	
	if Play_Time.is_stopped():
		queue_free()
