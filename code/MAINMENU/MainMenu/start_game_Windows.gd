extends Window

@export var BackButton : Button
@export var StartCanvas: CanvasModulate
@export var WindowStartCanvas: CanvasModulate

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _Back_MainMenu() -> void:
	visible = false


func _Random_Level() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(
		StartCanvas,
		"color",
		Color(),
		1.0
	)
	tween.tween_property(
		WindowStartCanvas,
		"color",
		Color(),
		1.0
	)
	
	await tween.finished
	get_tree().change_scene_to_file("res://run_scene/RandomScene/RandomFirst/RandomMap.tscn")
