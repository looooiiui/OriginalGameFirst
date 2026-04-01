extends Node2D

@export var CrossHair : Node2D
@export var toMouse : Line2D
@export var is_Line : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 99

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("line_display"):
		is_Line = !is_Line

	CrossHair.global_position = get_global_mouse_position()
	if is_Line:
		toMouse.points[0] = Player.instance.global_position
		toMouse.points[1] = get_global_mouse_position() 
	else:
		toMouse.points[0] = Vector2(0, 0)
		toMouse.points[1] = Vector2(0, 0)
