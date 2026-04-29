extends Control

@export var offset : Vector2 = Vector2 (0, -112)
@export var Player_Blood_Ui : Label
@export var player_Current_Blood : float
@export var dispaly_blood : float
@export var blood_Smooth : float = 0.1
@export var is_Smooth : bool = false  #此节点同步与另一血条节点(Blood Node2D)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
#	global_position = Player.instance.global_position + offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#玩家单例血条获取
	player_Current_Blood = Player.instance.real_hp
	
	
	if is_Smooth:
		global_position = lerp(global_position, Player.instance.global_position + offset, 0.1)
		dispaly_blood = lerp(dispaly_blood, player_Current_Blood, blood_Smooth)
		Player_Blood_Ui.text = "Hp: %.1f" % dispaly_blood
	else:
		dispaly_blood = lerp(dispaly_blood, player_Current_Blood, blood_Smooth)
		global_position = Player.instance.global_position + offset
		Player_Blood_Ui.text = "Hp: %.1f" % dispaly_blood
