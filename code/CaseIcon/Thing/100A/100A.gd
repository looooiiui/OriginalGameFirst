extends Node2D

enum GunType {ORIGINAL, ORIGINALMORE}
enum GunState {HAND, DROP}

static var id_dic : Dictionary[int, String] = {
	GunType.ORIGINAL : "10000G",
	GunType.ORIGINALMORE : "10001G"
}

@export var current_state : GunState
@export var gunType : GunType
@export var could_Buttle : Array[String]
@export var nowSelect : int = 0
@export var nono : PackedScene
@export var OriginalCoolTime : float = 0.3
@export var realCoolTime : float = OriginalCoolTime
@export var OriginalCoolTimer : Timer
@export var in_hand : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if current_state == GunState.HAND:
		_hand_state()
	else:
		_drop_state(delta)

	_player_detect()

func _drop_state(delta: float):
		global_rotation += deg_to_rad(60) * delta


func _hand_state():
	global_position = Player.instance.global_position
	global_rotation = Player.instance.global_rotation
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

func _player_detect():
	if drop_thing.instance != null and Player.instance != null:
		if Player.instance.global_position.x < global_position.x + drop_thing.instance.take_range:
			if Player.instance.global_position.x > global_position.x - drop_thing.instance.take_range:
				if Player.instance.global_position.y < global_position.y + drop_thing.instance.take_range:
					if Player.instance.global_position.y > global_position.y - drop_thing.instance.take_range:
						if Input.is_action_just_pressed("take_drop") and current_state != GunState.HAND:
							PlayerUI.instance.BackPackNode.BackPackWindows.check_empty(id_dic[gunType])
							queue_free()

	if current_state == GunState.HAND:
		if Input.is_action_just_pressed("drop"):
			current_state = GunState.DROP
