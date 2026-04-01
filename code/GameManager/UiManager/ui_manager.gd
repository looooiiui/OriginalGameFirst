extends Node2D


#子管理器引入
@export var GameoverUi : Node2D


#额外引入
@export var BloodControl : Control
@export var BloodControlAnim : Node2D
#标准引入
@export var ScenceMonster : Label
@export var MonsterLimited : Label
@export var PlayerHp : Label
@export var PlayerHpMax : Label
@export var PlayerGlobalPosition : Label
@export var PlayerCurrentSpeed : Label
@export var PlayerSpeedLimited : Label
@export var PlayerSpeedSmooth : Label
@export var CameraSmooth : Label
@export var BloodSmooth : Label
@export var PlayerMagicPoint : Label

var monster_real_num : int
var monster_limited : int
var player_Hp : float
var player_max_Hp : float
var playerGlobalPosition : Vector2
var playerCurrentSpeed : Vector2
var playerSpeedLimited : float
var playerSpeedSmooth : float
var cameraSmooth : bool
var bloodSmooth : bool
var playerMagicPoint : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#变量获取
	monster_real_num = GameManager.instance.monster_real_num
	monster_limited = GameManager.instance.monster_all_num
	player_Hp = Player.instance.real_hp
	player_max_Hp = Player.instance.max_hp
	playerGlobalPosition = Player.instance.global_position
	playerCurrentSpeed = Player.instance.velocity
	playerSpeedLimited = Player.instance.move_speed
	playerSpeedSmooth = Player.instance.move_smooth
	playerMagicPoint = Player.instance.magic_Point
	
	Monster_Num_Ui()
	Monster_limited_Ui()
	Player_Hp_Ui()
	Player_Hp_Max_Ui()
	Player_Global_Position()
	Player_Current_Speed()
	Player_Speed_Limited()
	Player_Speed_Smooth()
	Camera_Smooth_control()
	Player_MagicPoint()
	
func Monster_Num_Ui():
	ScenceMonster.text = "ScenceMonsterNum : %d" % monster_real_num 

func Monster_limited_Ui():
	MonsterLimited.text = "MonsterLimited : %d" % monster_limited
	
func Player_Hp_Ui():
	PlayerHp.text = "PlayerHp : %.1f" % player_Hp
	
func Player_Hp_Max_Ui():
	PlayerHpMax.text = "PlayerHpMax : %.1f" % player_max_Hp

func Player_Global_Position():
	PlayerGlobalPosition.text = "PPGlobalPosition : POSITION_X_Y %.3f / %.3f" % [playerGlobalPosition.x, playerGlobalPosition.y]

func Player_Current_Speed():
	PlayerCurrentSpeed.text = "PlayerCurrentSpeed : %.3f" % playerCurrentSpeed.length()

func Player_Speed_Limited():
	PlayerSpeedLimited.text = "PlayerSpeedLimited : %.3f" % playerSpeedLimited
	
func Player_Speed_Smooth():
	PlayerSpeedSmooth.text = "PlayerSpeedSmooth : %.3f" % playerSpeedSmooth

func Player_MagicPoint():
	PlayerMagicPoint.text = "MagicPoint : %.3f" % playerMagicPoint
	
func Camera_Smooth_control():
	var stringBool : String
	cameraSmooth = GCamera.instance.is_Smooth
	if cameraSmooth:
		stringBool = "true"
	else:
		stringBool = "false"
	CameraSmooth.text = "CameraSmooth : %s" % stringBool
	


#功能管理(节点)
func game_Over():
	if GameManager.instance.is_Game_Over:
		GameoverUi.GameOverLabel.visible = true
	else:
		GameoverUi.GameOverLabel.visible = false
