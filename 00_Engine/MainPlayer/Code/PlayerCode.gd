class_name Player

extends CharacterBody2D

signal hp_change(current_hp : float, original_hp : float)
signal player_State(original_hp : float)
 
static var instance : Player
static var input_Enable : bool = false

#-------玩家主要变量-------#
@export var move_speed : float = 1000
@export var playerToward : bool = true
@export var meleeDamage : float = 20
@export var Melee : PackedScene
@export var current_Grip : Vector2i
@export var level : int = 1
@export var experience: float = 0
@export var maxExperience: float = 100

#计时器
@export var original_time : float = 0.3
@export var MeleeCooldown : Timer
#玩家血量系统---------
@export var max_hp : float = 200
@export var real_hp : float = 200
#移动平滑度
@export var move_smooth : float = 200
@export var stop_smooth : float = 200
@export var Back_effect : PackedScene
@export var rotate_Smooth : float = 1
#玩家动画控制
@export var is_running : bool = false
@export var is_Melee : bool = false
#物品控制
@export var now_Arm_select : int = 0
#肉鸽元素控制
@export var max_Magic_Point : float = 200
@export var magic_Point : float = max_Magic_Point
@export var attackDamageMag : float = 1.0
@export var defense_Mag : float = 1
@export var magic_Attack_Mag : float = 1.0
@export var magic_defense_Mag : float = 1.0
@export var dexterity_Mag : float = 1.0
@export var strength_Mag : float = 1.0
@export var intelligence_Mag : float = 1.0
@export var vitality_Mag : float = 1.0
@export var allCoolTime_Mag : float = 1.0


var input_dir : Vector2
var is_time : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Player.instance == null:
		Player.instance = self
	else:
		queue_free()
	
	global_position = Vector2(0, 100)
	get_tree().root.remove_child(self)
	get_tree().current_scene.add_child(self)
	
	
func _process(delta: float) -> void:
	_Mag_Control()
	_player_Exprience()
	_Clamp_Attribute()
	now_Arm_select = PlayerUI.instance.currentSelect


func _physics_process(delta: float) -> void:
	
	_cal_Grip_Position()
	_player_move()
	_playerStateControl()
	_melee_judge()
	move_and_slide()
	
	
func _player_move() -> void:
	if input_Enable:
		input_dir = Input.get_vector("left", "right", "up", "down")
		input_dir = input_dir.normalized()
		get_Toward()
	
	#加速移动
	if input_dir != Vector2.ZERO:
		velocity.x = move_toward(velocity.x, input_dir.x * move_speed, move_smooth)
		velocity.y = move_toward(velocity.y, input_dir.y * move_speed, move_smooth)

	else:
		velocity.x = move_toward(velocity.x, 0, stop_smooth)
		velocity.y = move_toward(velocity.y, 0, stop_smooth)

	#平滑转向
	var mouse_pos = get_global_mouse_position()
	var target_dir = (mouse_pos - global_position).angle()
	var target_dir_change = wrapf(target_dir - rotation, -PI, PI)
	rotation = lerp(rotation, wrapf(rotation + target_dir_change, -2 * PI, 2 * PI), rotate_Smooth)
	
	#加速代码
	if (Input.is_action_pressed("run")):
		var temp_effect = Back_effect.instantiate()
		velocity += input_dir * 100
		get_tree().current_scene.add_child(temp_effect)

func _playerStateControl() -> void:
	if velocity.length() > 0.01:
		is_running = true
	else:
		is_running = false
	
#近战控制
func _melee_judge() -> void:
	if Input.is_action_just_pressed("melee") and !is_Melee:
		is_Melee = true
		MeleeCooldown.start()
		var meleeStart = Melee.instantiate()
		add_child(meleeStart)
	if MeleeCooldown.is_stopped():
		is_Melee = false
		
#受伤信号
func _Clamp_Attribute() -> void:
	real_hp = clamp(real_hp, 0.0, max_hp)

func took_damage(damage : float):  
	real_hp -= damage * (1 / defense_Mag)
	hp_change.emit(real_hp, max_hp)
	
func get_Toward():
	if input_dir.x > 0:
		playerToward = true
	elif input_dir.x < 0:
		playerToward = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and input_Enable:
			pass

func _cal_Grip_Position():
	current_Grip = Grid.instance.to_grid(global_position)
	
func _player_Exprience() -> void:
	maxExperience = level * 100
	
	if (experience >= maxExperience):
		level += 1
		experience = 0
		
func _Mag_Control() -> void:
	attackDamageMag = 1 + (level - 1) * 0.1
	allCoolTime_Mag = 1 + (level - 1) * 0.1
	defense_Mag = 1 + (level - 1) * 0.1
	
func _player_state_reset() -> void:

	global_position = Vector2(0, 100)
	level = 1
	experience = 0
	real_hp = max_hp
	now_Arm_select = 0
	magic_Point = max_Magic_Point
	attackDamageMag = 1.0
	defense_Mag = 1
	magic_Attack_Mag = 1.0
	magic_defense_Mag  = 1.0
	dexterity_Mag = 1.0
	strength_Mag = 1.0
	intelligence_Mag = 1.0
	vitality_Mag = 1.0
	allCoolTime_Mag = 1.0
