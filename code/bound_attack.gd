class_name Bullet

extends Area2D

enum BulletKind {BULLET, BULLETLITTLE, BULLETMORELIILE}

static var BulletDamage : Dictionary[String, float] = {
	"BULLET" : 20.0,
	"BULLETLITTLE" : 20.0,
	"BULLETMORELIILE" : 3.0
}
static var BulletCooldown : Dictionary[String, float] = {
	"BULLET" : 0.3,
	"BULLETLITTLE" : 0.1,
	"BULLETMORELIILE" : 0.04
}
static var BulletRecoil : Dictionary[String, float] = {
	"BULLET" : 100,
	"BULLETLITTLE" : 40,
	"BULLETMORELIILE" : 10
}
@export var type : BulletKind
@export var speed : float = 900
@export var cooldown_Time : float
@export var spawn_Sp : GPUParticles2D
@export var spawn_Sp2 : GPUParticles2D
@export var back_gpu : GPUParticles2D
@export var Bullet_model : Node2D
@export var damage : float = 0.0
@export var speedOffset : Vector2
@export var is_Speed_Offset_Get : bool = false

var dead_wait_time : float = 1.0
var fly_direction : Vector2 = Vector2.ZERO
var is_hited : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fly_direction = Player.instance.transform.x
	#时间重置
	await get_tree().create_timer(10.0).timeout
	queue_free()

	
func _process(delta: float) -> void:
	if !is_Speed_Offset_Get:
		speedOffset = Player.instance.transform.x * Player.instance.velocity.length()
		is_Speed_Offset_Get = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	#武器伤害初始化
	if abs(0.0 - damage) < 0.001:
		damage = BulletDamage[BulletKind.keys()[type]] * Player.instance.attackDamageMag
	if abs(0.0 - cooldown_Time) < 0.001:
		cooldown_Time = BulletCooldown[BulletKind.keys()[type]] * (1 / Player.instance.allCoolTime_Mag)
	if fly_direction.length() > 0 and not is_hited:
		global_position += fly_direction.normalized() * speed * delta + speedOffset * delta
		
func _hited(area: Area2D) -> void:
	if not is_hited and area.is_in_group("Monster") and not area.is_dead:
		if is_hited:
			return
		
		is_hited = true
		Bullet_model.visible = false
		back_gpu.emitting = false
		queue_free()
		
	
