extends Node2D

@export var currentLevel : int = 9999
@export var gameTip: PackedScene
@export var InCanvas: ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.instance.currentLevel = 9999
	GameManager.instance.windowsCount = 0		
	_Enter_Level()
	_tipInitialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _Enter_Level() -> void:
	var originColor = InCanvas.color
	InCanvas.color = Color()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(
		InCanvas,
		"color",
		originColor,
		3.0
	)
	await tween.finished
	InCanvas.visible = false

func _tipInitialize() -> void:
	if TeachingSystem.instance.isTip and TeachingSystem.instance.FirstSave:		
		var tempTip = gameTip.instantiate()
		get_tree().current_scene.add_child(tempTip)
