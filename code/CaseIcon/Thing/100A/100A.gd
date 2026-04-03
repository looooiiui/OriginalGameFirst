extends Node2D

enum GunType {ORIGINAL, ORIGINALMORE}

@export var gunType : GunType
@export var could_Buttle : Array[String]
@export var nowSelect : int = 0
@export var nono : PackedScene
@export var OriginalCoolTime : float = 0.3
@export var realCoolTime : float = OriginalCoolTime
@export var OriginalCoolTimer : Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = Player.instance.global_position
	global_rotation = Player.instance.global_rotation
	
func _physics_process(delta: float) -> void:
	_cal_Attribute()
	_shoot()


func _shoot():
	#越界管理
	if gunType < 0 || gunType >= could_Buttle.size():
		return
	#物品越界管理
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and OriginalCoolTimer.is_stopped():
		if CaseIcon.instance.InstanceManager.InstanceDic.has(could_Buttle[gunType]):
			var gun_Bullet = CaseIcon.instance.InstanceManager.InstanceDic[could_Buttle[gunType]].instantiate()
			gun_Bullet.global_position = Player.instance.global_position
			gun_Bullet.global_rotation = Player.instance.global_rotation
			get_tree().current_scene.add_child(gun_Bullet)
			OriginalCoolTimer.wait_time = realCoolTime
			OriginalCoolTimer.start()
			
func _cal_Attribute():
	realCoolTime = OriginalCoolTime / Player.instance.allCoolTime_Mag
