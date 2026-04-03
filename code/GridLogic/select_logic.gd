class_name GripPic

extends Node2D

static var instance : GripPic

@export var SelectedGrid : PackedScene
@export var real_grip : Node2D
@export var currentGrip : Vector2i
@export var PerGrip : Vector2i
@export var is_Original : bool = false
@export var perLevel : int

var mouseGlobalPosition : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GripPic.instance == null:
		GripPic.instance = self
	else:
		queue_free()
	
	currentGrip = Vector2i(0, 0)
	PerGrip = Vector2i(0, 0)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !is_Original and GameManager.instance.currentLevel != 0:
		#初始化高亮图标
		perLevel = GameManager.instance.currentLevel
		real_grip = SelectedGrid.instantiate()
		real_grip.global_position = Grid.instance.snap(Vector2(-9999, -9999))
		get_tree().root.add_child(real_grip)
		
		is_Original = true
		
	if perLevel != GameManager.instance.currentLevel:
		if real_grip != null:
			real_grip.queue_free()
		real_grip = SelectedGrid.instantiate()
		real_grip.global_position = Grid.instance.snap(Vector2(-9999, -9999))
		get_tree().root.add_child(real_grip)
		perLevel = GameManager.instance.currentLevel
	
	_grid_HighLight()
	_clear_Main_Menu()
	
	
func _grid_HighLight():
	
	mouseGlobalPosition = get_global_mouse_position()
	currentGrip = Grid.instance.to_grid(mouseGlobalPosition)
	if currentGrip != PerGrip and real_grip != null:
		real_grip.global_position = Grid.instance.snap(mouseGlobalPosition)
		PerGrip = currentGrip
		
func _clear_Main_Menu():
	if GameManager.instance.currentLevel == 0:
		if real_grip != null:
			real_grip.queue_free()
			is_Original = false
