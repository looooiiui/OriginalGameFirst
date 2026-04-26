extends Label
	
@export var randomTime : float
@export var offsetX : float
@export var offsetY : float
@export var offset : Vector2
@export var realMag : float = 1
@export var targetMag : float = 10
@export var numberOut : float

func _ready() -> void:
	z_index = 100

func _process(delta: float) -> void:
		
	add_theme_font_size_override("font_size", numberOut * realMag)

func play_damage(number: int, start_pos: Vector2):
	
	numberOut = number
	targetMag = log(numberOut) / 2
		
	offsetX = randf_range(-100.0, 100.0)
	offsetY = randf_range(-100.0, 100.0)
	offset = Vector2(offsetX, offsetY)
	text = str(number)
	global_position = start_pos
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true)
	
	tween.tween_property(self, "realMag", targetMag, 0.6)
	tween.tween_property(self, "global_position", start_pos + offset, 0.6)
	tween.tween_property(self, "modulate:a", 0.0, 2)
	
	await tween.finished
	queue_free()
