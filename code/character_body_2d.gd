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
@export var real_time : float = 0.3
@export var MeleeCooldown : Timer
#玩家血量系统---------
@export var max_hp : float = 200
@export var real_hp : float = 200
@export var PlayerBlood : Node2D
@export var BloodControl : Control
#移动平滑度
@export var move_smooth : float = 200
@export var stop_smooth : float = 200
@export var Back_effect : PackedScene
@export var back_attack : float = 100
@export var rotate_Smooth : float = 1
@export var CameraControl : Camera2D
#玩家动画控制
@export var PlayerSprite : Sprite2D
@export var PlayerAction : AnimatedSprite2D
@export var is_running : bool = false
@export var is_Melee : bool = false
#物品控制
@export var now_Arm_select : int = 0
@export var offset : Vector2 = Vector2(50, 17)
#肉鸽元素控制
@export var max_Magic_Point : float = 200
@export var magic_Point : float = max_Magic_Point
@export var attackDamageMag : float = 1.0
@export var defense_Mag : float = 1.0
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
	
	PlayerAction.play("idle")
	
func _process(delta: float) -> void:
	_Mag_Control()
	_player_Exprience()
	now_Arm_select = PlayerUI.instance.currentSelect


func _physics_process(delta: float) -> void:
	
	_cal_Grip_Position()
	#玩家控制
	PlayerAction.global_position = global_position
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
		velocity += input_dir * 100
		var temp_effect = Back_effect.instantiate()
		get_tree().current_scene.add_child(temp_effect)
	#计时口
	if is_time:
		real_time -= delta
		if real_time < 0:
			is_time = false
			real_time = original_time
			
	#-------------------动画控制原型--------------------#
	#-------------------------------------------------#
	if input_dir.length() > 0 and is_running == false:
		PlayerAction.play("run")
		is_running = true
	elif input_dir.length() == 0 and is_running == true:
		PlayerAction.play("idle")
		is_running = false	
		
#	PlayerAction.flip_h = input_dir.x < 0	
	if input_dir.x > 0 and PlayerAction.flip_h:
		PlayerAction.flip_h = false
	elif input_dir.x < 0 and !PlayerAction.flip_h:
		PlayerAction.flip_h = true

	#-------------------------------------------------#
	#-------------------------------------------------#
	
		
	#------------------近战判断------------------#
	if Input.is_action_just_pressed("melee") and !is_Melee:
		is_Melee = true
		MeleeCooldown.start()
		var meleeStart = Melee.instantiate()
		add_child(meleeStart)
	if MeleeCooldown.is_stopped():
		is_Melee = false
	#控制移动
	move_and_slide()	
	
func _attack(select : int):
	pass
	
#受伤信号
func took_damage(damage : float):  
	real_hp -= damage
	real_hp = clamp(real_hp, 0.0, max_hp)
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
