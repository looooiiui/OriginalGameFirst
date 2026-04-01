extends Node2D

@export var BackPackWindows : Window
@export var is_BackPack_Visible : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BackPackWindows.popup_centered()
	BackPackWindows.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("backPack") and GameManager.instance.currentLevel != 0:
		BackPackWindows.visible = !BackPackWindows.visible
		GameManager.instance.is_Mouse_Visible = !GameManager.instance.is_Mouse_Visible
		is_BackPack_Visible = BackPackWindows.visible
