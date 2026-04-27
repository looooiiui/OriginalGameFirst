class_name GameManager

extends Node2D

static var instance : GameManager

#游戏综合管理
#------------------------------------------#
@export var monster_all_num : int = 10
@export var monster_real_num : int = 0
@export var MonsterManager : Node2D
#------------------------------------------#
#时间管理
@export var spawn_time : float = 1.0
@export var Monster_spwan_time : Timer
@export var is_Monster_spawn : bool = true
#---------------UI--------------#
@export var DebugInformation : CanvasLayer
@export var is_Debug : bool = false
@export var is_PlayerUI : bool = false
@export var WindowsManager : Node2D
@export var UiManager : Node2D
@export var windowsMaxlimited : int = 10
#--------------游戏关卡管理-------------#
@export var currentLevel : float = 0
@export var is_Track_Player : bool = false
@export var worldBoundaryXLeft : float = 0
@export var worldBoundaryXRight : float = 0
@export var worldBoundaryXUp : float = 0
@export var worldBoundaryXDown : float = 0
@export var is_Game_Over : bool = false
#--------------操控设置--------------#
@export var windowsCount : int = 0



func _ready() -> void:
	if GameManager.instance == null:
		GameManager.instance = self
	else:
		queue_free()
		
	Monster_spwan_time.wait_time = spawn_time
	Monster_spwan_time.start()
	Player.instance.input_Enable = true
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:

	_debug_imformation_display()
	
	windowsCount = clamp(windowsCount, 0, windowsMaxlimited)		
	Mouse_Visible()
	

	_player_state_control()
	_game_over_control()
	gameover_Hp_Clear()
	UI_Player_visible()

#玩家综合状态控制
func _player_state_control() -> void:
		#当前关卡玩家操纵控制
	if currentLevel == 0:
		is_PlayerUI = false
	else:
		is_PlayerUI = true
	
	#---------玩家控制系统--------#
	if currentLevel == 0:
		Player.instance.input_Enable = false
	else:
		Player.instance.input_Enable = true


#游戏结束控制
func _game_over_control() -> void:
	if is_Game_Over and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		is_Game_Over = false
		Player.instance._player_state_reset()
		get_tree().change_scene_to_file("res://run_scene/main_menu.tscn")
		UiManager.game_Over()

#--------调试信息显示-------#
func _debug_imformation_display() -> void:
	if Input.is_action_just_pressed("debug"):
		if is_Debug == false:
			DebugInformation.visible = true
			is_Debug = true
		else:
			DebugInformation.visible = false
			is_Debug = false

func Mouse_Visible():
	#防windows出错
	
	if windowsCount > 0:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CONFINED_HIDDEN
		
func UI_Player_visible():
	if is_PlayerUI:
		PlayerUI.instance.visible = true
	else:
		PlayerUI.instance.visible = false	

func gameover_Hp_Clear():
	if Player.instance.real_hp <= 0.001:
		is_Game_Over = true
		Player.input_Enable = false
		UiManager.game_Over()
