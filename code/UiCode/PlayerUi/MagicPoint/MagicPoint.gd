extends Node2D

@export var Magic_Player : AnimationPlayer

var real_play_time : float
var all_play_time : float
var target_play_time : float
var player_real_Mp : float
var player_all_Mp : float
var player_Mp_per : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_Magic_Player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	
#----------玩家血条管理---------#
	_blood_Play(delta)

func _Magic_Player():
	if Magic_Player.current_animation != "MagicPoint":
		var anim = Magic_Player.get_animation("MagicPoint")
		if anim == null:
			queue_free()
		else:
			Magic_Player.play("MagicPoint")
			all_play_time = Magic_Player.current_animation_length
			real_play_time = 0.0
			target_play_time = all_play_time - 0.1
			player_Mp_per = 1.0

func _blood_Play(delta : float):
	target_play_time = all_play_time * player_Mp_per
	target_play_time = clamp(target_play_time, 0.0, all_play_time - 0.1)
	real_play_time = lerp(real_play_time, target_play_time, 3 * delta)
	Magic_Player.seek(real_play_time, true)

	player_all_Mp = Player.instance.max_Magic_Point
	player_real_Mp = Player.instance.magic_Point
	player_Mp_per = player_real_Mp / player_all_Mp
	player_Mp_per = clamp(player_Mp_per, 0.0, 1.0)
