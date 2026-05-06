class_name PlayerUI

extends Node2D

static var instance : PlayerUI

@export var Blood_player : AnimationPlayer
@export var currentSelect : int = 0
@export var ArmInventory : Node2D
@export var BackPackNode : Node2D

var real_play_time : float
var all_play_time : float
var target_play_time : float
var player_real_hp : float
var player_all_hp : float
var player_hp_per : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PlayerUI.instance == null:
		PlayerUI.instance = self
	else:
		queue_free()
	
	_blood_Player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	
#----------玩家血条管理---------#
	_blood_Play(delta)

func _blood_Player():
	if Blood_player.current_animation != "Blood":
		var anim = Blood_player.get_animation("Blood")
		if anim == null:
			queue_free()
		else:
			Blood_player.play("Blood")
			all_play_time = Blood_player.current_animation_length
			real_play_time = 0.0
			target_play_time = all_play_time - 0.1
			player_hp_per = 1.0

func _blood_Play(delta : float):
	target_play_time = all_play_time * player_hp_per
	target_play_time = clamp(target_play_time, 0.0, all_play_time - 0.1)
	real_play_time = lerp(real_play_time, target_play_time, 3 * delta)
	Blood_player.seek(real_play_time, true)
	
	player_all_hp = Player.instance.max_hp
	player_real_hp = Player.instance.real_hp
	player_hp_per = player_real_hp / player_all_hp
	player_hp_per = clamp(player_hp_per, 0.0, 1.0)
