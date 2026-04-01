extends Area2D

#贴图管理
@export var model_little : Sprite2D
@export var model_back : Sprite2D
@export var model_toward : Sprite2D
@export var model_blood_back : Sprite2D
@export var model_blood : Sprite2D
@export var originalColor : Color
@export var color_Smooth : float = 0.01

@export var random_speed : float
@export var timer_manager : Timer
@export var Dead_Time : Timer
#血条管理
@export var original_blood : float = 100
@export var current_blood : float = original_blood
#速度管理
@export var min_speed : float = 100
@export var max_speed : float = 300
@export var real_speed : Vector2
#死亡管理
@export var dead_time : float = 2
@export var is_dead : bool = false
@export var hited_re_effort : PackedScene
@export var Dead_Player : GPUParticles2D
@export var Dead_exp_Player : GPUParticles2D
@export var is_play_dead : bool = false
#怪物UI管理 
@export var Blood_Ui : Label
@export var Blood_Ui_Smooth : float = 0.1
#击中管理
@export var DamageDisplay : PackedScene
#血条信号发射d
signal blood(current_blood : float, original_blood : float)

var target_rotation : float
var real_Play_Blood : float
var change_angle : float
var hit_cache: Array[Area2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	target_rotation = rotation
	random_speed = randf_range(min_speed, max_speed)
	rotation = randf_range(-PI, PI)
	#时间重置
	Dead_Time.start(dead_time)
	#受伤颜色管理初始化
	originalColor = model_little.modulate
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var toward : Vector2
	toward = transform.x
	if not is_dead:
		global_position = global_position + toward * random_speed * delta
		real_speed = toward * random_speed * 60
	#转角平滑
	rotation = lerp(rotation, target_rotation, 8 * delta)
func _process(delta: float) -> void:
	
	#---------死亡播放节点---------#
	if Dead_Time.time_left <= 1.001 and is_dead and not is_play_dead:
		Dead_exp_Player.restart()
		Blood_Ui.visible = false
		model_little.visible = false
		model_back.visible = false
		model_toward.visible = false
		model_blood.visible = false
		model_blood_back.visible = false
		is_play_dead = true
	
	if Dead_Time.is_stopped() and current_blood <= 0.001 and is_dead:
		queue_free()
	
	#------血条控制UI界面------#
	real_Play_Blood = lerp(real_Play_Blood, current_blood, Blood_Ui_Smooth)
	Blood_Ui.text = "Hp: %.1f" % real_Play_Blood
	
	
	#------受伤管理------#
	model_little.modulate = lerp(model_little.modulate, originalColor, color_Smooth)

	#-------边界管理------#
	out_Boundary(global_position.x, global_position.y)
	
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("Player") and not is_dead:
		body.took_damage(20)

#改变角度的
func _is_time_change() -> void:
	if not is_dead:
		target_rotation = target_rotation + change_angle
		change_angle = randf_range(-PI / 4, PI / 4)
		timer_manager.wait_time = randf_range(0.5, 2)
	


#受到击扣血
func took_damage(damage):
	if not is_dead:
		model_little.modulate = Color(0.933, 0.0, 0.0, 1.0)
		current_blood -= damage
		current_blood = clamp(current_blood, 0.0, original_blood)
		blood.emit(current_blood, original_blood)
		var temp_effort = hited_re_effort.instantiate()
		add_child(temp_effort)
		if current_blood <= 0.001 and not is_dead:
			is_dead = true
			hit_cache.clear()
			Dead_Player.restart()
			Dead_Time.start()


func _be_hited(area: Area2D) -> void:
	if area.is_in_group("Attack") and not is_dead:
		if hit_cache.has(area):
			return
		hit_cache.append(area)
		
		took_damage(area.damage)
		var damageDisplay = DamageDisplay.instantiate()
		get_tree().current_scene.add_child(damageDisplay)
		damageDisplay.play_damage(area.damage, global_position)


func change_Global_Position(first : float, second : float):
	global_position.x = first
	global_position.y = second
	
func out_Boundary(realX : float, realY : float):
	if realX < GameManager.instance.worldBoundaryXLeft:
		global_position.x += 500.0
	if realX > GameManager.instance.worldBoundaryXRight:
		global_position.x -= 500.0
	if realY < GameManager.instance.worldBoundaryXDown:
		global_position.y += 500.0
	if realY > GameManager.instance.worldBoundaryXUp:
		global_position.y -= 500.0
	
	
