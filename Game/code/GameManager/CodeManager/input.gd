extends Control

@export var BloodControl : Control
@export var BloodControlAnim : Node2D
@export var MonsterLimited : LineEdit
@export var PlayerHpMax : LineEdit
@export var PlayerHp : LineEdit
@export var PPGlobalPosition : LineEdit
@export var PlayerSpeedLimited : LineEdit
@export var PlayerSpeedSmooth : LineEdit
@export var PlayerMagicPoint : LineEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _Tp_Edit(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("^-?\\d+(\\.\\d+)? -?\\d+(\\.\\d+)?$")
	if regex.search(new_text):
		var part : Array = new_text.split(" ")
		print("Recive global position: " + part[0] +  " " + part[1])
		Player.instance.global_position.x = part[0].to_float()
		Player.instance.global_position.y = part[1].to_float()
		
	else:
		print("ERROR")

	PPGlobalPosition.clear()
	PPGlobalPosition.release_focus()

func _Player_Hp_Max_Change(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("^-?\\d+(\\.\\d+)?$")
	if regex.search(new_text):
		print("Recive new max hp: " + new_text)
		Player.instance.max_hp = new_text.to_float()

	else:
		print("ERROR")
	
	PlayerHpMax.clear()
	PlayerHpMax.release_focus()
		
func _Player_Current_hp(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("^-?\\d+(\\.\\d+)?$")
	if regex.search(new_text):
		print("Recive current max hp: " + new_text)
		Player.instance.real_hp = new_text.to_float()
	else:
		print("ERROR")

	PlayerHp.clear()
	PlayerHp.release_focus()

func _Player_Speed_Limited(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("^-?\\d+(\\.\\d+)?$")
	if regex.search(new_text):
		print("Recive current max speed: " + new_text)
		Player.instance.move_speed = new_text.to_float()
	else:
		print("ERROR")
		
	PlayerSpeedLimited.clear()
	PlayerSpeedLimited.release_focus()
	
func _Player_Speed_Smooth(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("^-?\\d+(\\.\\d+)?$")
	if regex.search(new_text):
		print("Recive Speed Smooth: " + new_text)
		Player.instance.move_smooth = new_text.to_float()
	else:
		print("ERROR")
		
	PlayerSpeedSmooth.clear()
	PlayerSpeedSmooth.release_focus()


func _Scence_Monster_Limited(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("^-?\\d+(\\.\\d+)?$")
	if regex.search(new_text):
		print("Recive Monster Limited: " + new_text)
		GameManager.instance.monster_all_num = new_text.to_float()
	else:
		print("ERROR")
	
	MonsterLimited.clear()
	MonsterLimited.release_focus()


func _camera_Smooth_Switch() -> void:
	var is_smooth : bool = GCamera.instance.is_Smooth
	if is_smooth:
		GCamera.instance.is_Smooth = false
	else:
		GCamera.instance.is_Smooth = true


func _magic_Point_Change(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("^-?\\d+(\\.\\d+)?$")
	if regex.search(new_text):
		print("Recive current MagicPoint: " + new_text)
		Player.instance.magic_Point = clamp(new_text.to_float(), 0, Player.instance.max_Magic_Point)
	else:
		print("ERROR")

	PlayerMagicPoint.clear()
	PlayerMagicPoint.release_focus()
