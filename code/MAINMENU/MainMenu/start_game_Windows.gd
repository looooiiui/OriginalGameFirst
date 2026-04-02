extends Window

@export var BackButton : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _Back_MainMenu() -> void:
	visible = false


func _Original_Level() -> void:
	get_tree().change_scene_to_file("res://run_scene/Level/node_2d.tscn")


func _Random_Level() -> void:
	get_tree().change_scene_to_file("res://run_scene/RandomScene/RandomFirst/RandomMap.tscn")
