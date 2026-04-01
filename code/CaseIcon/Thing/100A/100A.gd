extends Node2D

@export var could_Buttle : Array[String]
@export var nowSelect : int = 0
@export var nono : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = Player.instance.global_position
	global_rotation = Player.instance.global_rotation
	_change_Bullet()
func _physics_process(delta: float) -> void:
	_shoot()
	
#改变可用子弹		
func _change_Bullet():
	if Input.is_action_just_pressed("mode_right"):
		nowSelect += 1
		nowSelect = clamp(nowSelect, 0, could_Buttle.size() - 1)
	if Input.is_action_just_pressed("mode_left"):
		nowSelect -= 1
		nowSelect = clamp(nowSelect, 0, could_Buttle.size() - 1)
		
func _shoot():
	#越界管理
	if nowSelect < 0 || nowSelect >= could_Buttle.size():
		return
	#物品越界管理
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if CaseIcon.instance.InstanceManager.InstanceDic.has(could_Buttle[nowSelect]):
			var gun_Bullet = CaseIcon.instance.InstanceManager.InstanceDic[could_Buttle[nowSelect]].instantiate()
			gun_Bullet.global_position = Player.instance.global_position
			gun_Bullet.global_rotation = Player.instance.global_rotation
			get_tree().current_scene.add_child(gun_Bullet)	
