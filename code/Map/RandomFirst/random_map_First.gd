extends Node2D

@export var currentLevel : int = 9999
@export var InCanvas: CanvasModulate

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.instance.currentLevel = 9999
	GameManager.instance.windowsCount = 0		
	_Enter_Level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _Enter_Level() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(
		InCanvas,
		"color",
		Color(1.0, 1.0, 1.0, 1.0),
		1.0
	)
