extends AnimatedSprite2D

@export var offsetDis : Vector2 = Vector2(45, 20)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#	if Player.instance.input_dir.x > 0:
#		offsetDis = Vector2(45, 20)
#	if Player.instance.input_dir.x < 0:
#		offsetDis = Vector2(-45, 20)
	global_position = Player.instance.global_position
	#if global_rotation > PI / 4 or global_rotation < PI / 4:
	#	flip_h = true
	look_at(get_global_mouse_position())
