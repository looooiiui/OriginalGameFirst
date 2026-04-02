extends Node2D

@export var ExitMenu : Window

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ExitMenu.popup_centered()
	ExitMenu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ExitMenu"):
		change_Windows_Visible()

func change_Windows_Visible():
	ExitMenu.visible = !ExitMenu.visible
	if ExitMenu.visible == true:
		GameManager.instance.windowsCount += 1
	else:
		GameManager.instance.windowsCount -= 1


func _return_Main_menu() -> void:
	get_tree().change_scene_to_file("res://run_scene/main_menu.tscn")
	Player.instance.real_hp = Player.instance.max_hp
	GameManager.instance.is_Game_Over = false
	ExitMenu.visible = false


func _return_To_Desktop() -> void:
	get_tree().quit()
