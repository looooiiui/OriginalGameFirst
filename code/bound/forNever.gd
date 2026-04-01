extends Sprite2D
@export var NODE : Area2D

var per_global_position : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = NODE.global_position
	per_global_position = NODE.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	global_position = per_global_position
	
	
	per_global_position = global_position
