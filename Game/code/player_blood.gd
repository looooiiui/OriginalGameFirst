extends Node2D

@export var BloodPlayer : AnimationPlayer
@export var offset : Vector2 = Vector2(0, -100)
@export var blood_Player_smooth : float =  0.08
@export var is_Smooth : bool = false

var current_play_time : float
var all_play_time : float
var player_hp_pec : float
var blood_play_pec : float 
var goal_position : Vector2
var need_time : float

# Called when the node enters the scene tree for the first time.
#播放动画
func _ready() -> void:
	if not BloodPlayer:
		queue_free()
		return
	if BloodPlayer.current_animation != "blood":
		BloodPlayer.play("blood")
		var anim = BloodPlayer.get_animation("blood")
		if anim:
			anim.loop = true
		else:
			queue_free()
		BloodPlayer.seek(BloodPlayer.current_animation_length - 0.1, true)
		BloodPlayer.pause()
		#need_time要初始值
		need_time = BloodPlayer.current_animation_length - 0.1
		#初始玩家位置
		#global_position = Player.instance.global_position + offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#玩家单例获取变量点
	all_play_time = BloodPlayer.current_animation_length
	player_hp_pec = Player.instance.real_hp / Player.instance.max_hp
	blood_play_pec = current_play_time / all_play_time
	player_hp_pec = clamp(player_hp_pec, 0.0, 1.0)
	blood_play_pec = clamp(blood_play_pec, 0.0, 1.0)
	
	if is_Smooth:
		goal_position = Player.instance.global_position + offset
		global_position = lerp(global_position, goal_position, 0.1)
	else:
		goal_position = Player.instance.global_position + offset
		global_position = goal_position
	#血条平滑
	if (blood_play_pec != player_hp_pec):	
		need_time = player_hp_pec * all_play_time
		if abs(need_time - BloodPlayer.current_animation_length) < 0.1:
			need_time = BloodPlayer.current_animation_length - 0.1
	#平滑
	current_play_time = BloodPlayer.current_animation_position
	BloodPlayer.seek(lerp(current_play_time, need_time, blood_Player_smooth), true)
