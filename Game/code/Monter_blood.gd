extends Node2D

@export var Monster : Area2D
@export var offset : Vector2 = Vector2(0, 0)
@export var smooth : float = 0.1
@export var Blood_player : AnimationPlayer
@export var blood_high : float = 1.3 #血条头顶比例
@export var Sprite : Sprite2D

var real_play_time : float
var all_play_time : float
var target_play_time : float
var play_time_per : float
var monster_real_hp : float
var monster_all_hp : float
var monster_hp_per : float
var final_offset : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#血条位置自动调整
	if Sprite != null and Sprite.texture != null:
		var real_high = Sprite.texture.get_height() * abs(Sprite.scale.y)
		final_offset = offset + Vector2.UP * (real_high / blood_high)
	else:
		final_offset = offset
	
	global_position = Monster.global_position + final_offset
	scale = Vector2(Sprite.scale.x, Sprite.scale.y)
	
	if Blood_player.current_animation != "blood":
		var anim = Blood_player.get_animation("blood")
		if anim == null:
			queue_free()
		else:
			Blood_player.play("blood")
			all_play_time = Blood_player.current_animation_length
			real_play_time = 0.0
			target_play_time = all_play_time - 0.1
			monster_hp_per = 1.0
		
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = lerp(global_position, Monster.global_position  + final_offset, smooth)
	
	#控制血条
	#---------------------------------------#
	target_play_time = all_play_time * monster_hp_per
	target_play_time = clamp(target_play_time, 0.0, all_play_time - 0.1)
	real_play_time = lerp(real_play_time, target_play_time, 3 * delta)
	Blood_player.seek(real_play_time, true)
	#---------------------------------------#
func _on_little_test_attack_blood(current_blood: float, original_blood: float) -> void:
	monster_all_hp = original_blood
	monster_real_hp = current_blood
	monster_hp_per = current_blood / original_blood
	monster_hp_per = clamp(monster_hp_per, 0.0, 1.0)


func _begin_blood_out() -> void:
	Blood_player.pause()
