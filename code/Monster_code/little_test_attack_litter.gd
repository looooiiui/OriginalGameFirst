extends Area2D

#贴图管理
@export var model_little : Sprite2D
@export var model_back : Sprite2D
@export var model_toward : Sprite2D
@export var model_blood_back : Sprite2D
@export var model_blood : Sprite2D

@export var random_speed : float
@export var timer_manager : Timer
@export var Dead_Time : Timer
#血条管理
@export var original_blood : float = 50
@export var current_blood : float = original_blood
#速度管理
@export var min_speed : float = 300
@export var max_speed : float = 600
#死亡管理
@export var dead_time : float = 2
@export var is_dead : bool = false
@export var hited_re_effort : PackedScene
@export var Dead_Player : GPUParticles2D
@export var Dead_exp_Player : GPUParticles2D
@export var is_play_dead : bool = false

#血条信号发射d
signal blood(current_blood : float, original_blood : float)

var target_rotation : float

var change_angle : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	target_rotation = rotation
	random_speed = randf_range(min_speed, max_speed)
	rotation = randf_range(-PI, PI)
	#时间重置
	Dead_Time.start(dead_time)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var toward : Vector2
	toward = transform.x
	if not is_dead:
		global_position = global_position + toward * random_speed * delta
	#转角平滑
	rotation = lerp(rotation, target_rotation, 8 * delta)
func _process(delta: float) -> void:
	
	#---------死亡播放节点---------#
	if Dead_Time.time_left <= 1.001 and is_dead and not is_play_dead:
		Dead_exp_Player.restart()
		model_little.visible = false
		model_back.visible = false
		model_toward.visible = false
		model_blood.visible = false
		model_blood_back.visible = false
		is_play_dead = true
	
	if Dead_Time.is_stopped() and current_blood <= 0.001 and is_dead:
		queue_free()
	
	

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
		current_blood -= damage
		current_blood = clamp(current_blood, 0.0, original_blood)
		blood.emit(current_blood, original_blood)
		var temp_effort = hited_re_effort.instantiate()
		add_child(temp_effort)
		if current_blood <= 0.001 and not is_dead:
			is_dead = true
			Dead_Player.restart()
			Dead_Time.start()


func _be_hited(area: Area2D) -> void:
	if area.is_in_group("Attack") and not area.is_hited:
		took_damage(area.damage)


func change_Global_Position(first : float, second : float):
	global_position.x = first
	global_position.y = second
