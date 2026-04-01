extends Node2D

@export var PlayerAction : AnimatedSprite2D
@export var Gun : AnimatedSprite2D
@export var input_dir : Vector2
@export var is_running : bool
@export var DeadEffect : PackedScene
@export var is_Dead_Effect_Play : bool = false
@export var is_Melee : bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerAction.play("idle")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	
	global_position = Player.instance.global_position
	input_dir = Player.instance.input_dir
	is_running = Player.instance.is_running
	is_Melee = Player.instance.is_Melee
	
	if is_running and !is_Melee:
		PlayerAction.play("run")
	elif !is_Melee:
		PlayerAction.play("idle")
	
#	PlayerAction.flip_h = input_dir.x < 0	
	if input_dir.x > 0 and PlayerAction.flip_h:
		PlayerAction.flip_h = false
	elif input_dir.x < 0 and !PlayerAction.flip_h:
		PlayerAction.flip_h = true
		
	if is_Melee:
		PlayerAction.play("melee")
	
		
	#------------游戏结束控制点------------#
	if GameManager.instance.is_Game_Over and !is_Dead_Effect_Play:
		is_Dead_Effect_Play = true
		visible = false
		var deadEffect = DeadEffect.instantiate()
		deadEffect.global_position = global_position
		get_tree().current_scene.add_child(deadEffect)
