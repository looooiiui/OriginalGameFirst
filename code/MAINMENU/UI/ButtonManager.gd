extends Node2D


@export var SmoothDegree : float = 1
#开始按钮
@export var StartButton : Button
@export var ButtonAnimStart : AnimatedSprite2D
@export var OriginalColorStart : Color
#设置按钮
@export var SettingButton : Button
@export var ButtonAnimSetting : AnimatedSprite2D
@export var OriginalColorSetting : Color
#离开按钮
@export var ExitButton : Button
@export var ExitAnimSetting : AnimatedSprite2D
@export var ExitOriginalSetting : Color
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OriginalColorStart = ButtonAnimStart.modulate
	OriginalColorSetting = ButtonAnimSetting.modulate
	ExitOriginalSetting = ExitAnimSetting.modulate
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Start_Button()
	Setting_Button()
	Exit_Button()

func Start_Button():
	if StartButton.is_hovered():
		ButtonAnimStart.modulate = Color(0.775, 0.775, 0.775, 1.0)
	elif StartButton.is_pressed():
		ButtonAnimStart.modulate = Color(0.427, 0.427, 0.427, 1.0)
	else:
		ButtonAnimStart.modulate = OriginalColorStart	

func Setting_Button():
	if SettingButton.is_hovered():
		ButtonAnimSetting.modulate = Color(0.775, 0.775, 0.775, 1.0)
	elif SettingButton.is_pressed():
		ButtonAnimSetting.modulate = Color(0.427, 0.427, 0.427, 1.0)
	else:
		ButtonAnimSetting.modulate = OriginalColorSetting
		
func Exit_Button():
	if ExitButton.is_hovered():
		ExitAnimSetting.modulate = Color(0.775, 0.775, 0.775, 1.0)
	elif ExitButton.is_pressed():
		ExitAnimSetting.modulate = Color(0.427, 0.427, 0.427, 1.0)
	else:
		ExitAnimSetting.modulate = ExitOriginalSetting
