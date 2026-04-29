extends Node2D

@export var OriginalMonster: Node2D
@export var _Map_Generatop: Node2D
@export var _current_level: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _original_Manager() -> void:
	_current_level = 0
