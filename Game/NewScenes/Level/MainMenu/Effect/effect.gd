extends Node2D

@export var StartGameColor: ColorRect
@export var Logo: Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func startGame() -> void:
	StartGameColor.color = Color(0.0, 0.0, 0.0, 0.0)
	StartGameColor.visible = true
	var tween = create_tween()
		
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(
		StartGameColor,
		"color",
		Color(0.0, 0.0, 0.0, 1.0),
		3.0
	)
	await tween.finished
	get_tree().change_scene_to_file("res://Game/run_scene/RandomScene/RandomFirst/RandomMap.tscn")
	
func _initializeGame() -> void:
	StartGameColor.visible = true
	StartGameColor.color = Color()
	var tween = create_tween()
		
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(
		StartGameColor,
		"color",
		Color(1.0, 1.0, 1.0, 1.0),
		3.0
	)
	tween.tween_property(
		StartGameColor,
		"color",
		Color(0.0, 0.0, 0.0, 1.0),
		3.0
	)
	await tween.finished
	Logo.visible = false
	
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(
		StartGameColor,
		"color",
		Color(0.0, 0.0, 0.0, 0.0),
		3.0
	)
	await tween.finished
	StartGameColor.visible = false
