extends Window

@export var BackButton : Button
@export var StartCanvas: CanvasModulate
@export var WindowStartCanvas: CanvasModulate
@export var ArchiveWindows: Window
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _Back_MainMenu() -> void:
	visible = false


func _Random_Level() -> void:
	ArchiveWindows.size.x = 2
	ArchiveWindows.size.y = 1 
	ArchiveWindows.visible = true
	
