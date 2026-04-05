extends Node2D

@export var nowSelect : int = 0
@export var perSelect : int = 0
@export var armInventory : Array[Node2D]
@export var selectColor : Color = Color(0.148, 0.773, 0.953, 1.0)
@export var perUsing : int = 0
@export var is_first_add : bool = true
@export var BackPackWindows : Window

var original_Color : Color
var nowUsing = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_Color = armInventory[0].Back.modulate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	_first_attend()
	_change_Inventory(nowSelect)
	_change_Inventory_Select()
	_hand_Taken()
	
func get_Select_Id() -> int:
	return nowSelect

func _change_Inventory(now_Select : int):
	#防止超出边界(物品栏大小)
	if perSelect >= armInventory.size() || nowSelect >= armInventory.size():
		return
	
	armInventory[perSelect].Back.modulate = original_Color
	armInventory[nowSelect].Back.modulate = selectColor
	perSelect = nowSelect

#可以直接实例化的物品
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and Player.instance.input_Enable:
			if armInventory[nowSelect].selectId != "":
				if armInventory[nowSelect].selectId.length() >= 6 and armInventory[nowSelect].selectId[5] == "A":
					if armInventory[nowSelect].selectId in CaseIcon.instance.InstanceManager.InstanceDic:
						if CaseIcon.instance.InstanceManager.InstanceDic[armInventory[nowSelect].selectId] != null:
							var realCase = CaseIcon.instance.InstanceManager.InstanceDic[armInventory[nowSelect].selectId].instantiate()
							realCase.global_position = Player.instance.global_position
							realCase.global_rotation = Player.instance.global_rotation
							get_tree().current_scene.add_child(realCase)
				
				elif armInventory[nowSelect].selectId.length() >= 6 and armInventory[nowSelect].selectId[5] == "C":	
					if BackPackWindows.visible == false:
						if CaseIcon.instance.InstanceManager.InstanceDic[armInventory[nowSelect].selectId] != null:	
							var mouse_Grip_Position = Grid.instance.to_grid(_get_mouse_world_pos())
							if Player.instance.current_Grip != mouse_Grip_Position:
								var realCase = CaseIcon.instance.InstanceManager.InstanceDic[armInventory[nowSelect].selectId].instantiate()
								realCase.global_position = Grid.instance.snap(_get_mouse_world_pos())
								get_tree().current_scene.add_child(realCase)

#判断手持	
func _hand_Taken():
	if nowSelect != perUsing and Player.instance.input_Enable:
		#防止报空
		if armInventory[nowSelect].selectId != "":
			#防止字符串越界
			if armInventory[nowSelect].selectId.length() >= 6 and armInventory[nowSelect].selectId[5] == "G":
				if nowUsing != null:
					print("ni")
					if nowUsing.current_state == nowUsing.GunState.HAND:
						nowUsing.queue_free()
						nowUsing = null
					else:
						nowUsing = null
				#实例化手持物品
				if armInventory[nowSelect].selectId in CaseIcon.instance.InstanceManager.InstanceDic:
					nowUsing = CaseIcon.instance.InstanceManager.InstanceDic[armInventory[nowSelect].selectId].instantiate()
					nowUsing.current_state = nowUsing.GunState.HAND
					get_tree().current_scene.add_child(nowUsing)
			else:
				if nowUsing != null:
					nowUsing.queue_free()
					nowUsing = null
		else:
			if nowUsing != null:
				nowUsing.queue_free()
				nowUsing = null
		perUsing = nowSelect
	

func _change_Inventory_Select():
	if Input.is_action_just_pressed("first_arm"):
		perUsing = nowSelect
		nowSelect = 0
	elif Input.is_action_just_released("second_arm"):
		perUsing = nowSelect
		nowSelect = 1
	elif Input.is_action_just_pressed("Third_arm"):
		perUsing = nowSelect
		nowSelect = 2
	elif Input.is_action_just_pressed("forth_arm"):
		perUsing = nowSelect
		nowSelect = 3
	PlayerUI.instance.currentSelect = nowSelect	

func _first_attend():
	if is_first_add:
		if armInventory[nowSelect].selectId in CaseIcon.instance.InstanceManager.InstanceDic:
			if armInventory[nowSelect].selectId.length() >= 6:
				if Player.input_Enable:
					nowUsing = CaseIcon.instance.InstanceManager.InstanceDic[armInventory[nowSelect].selectId].instantiate()
					get_tree().current_scene.add_child(nowUsing)
					is_first_add = false
				if armInventory[nowSelect].selectId[5] == "C":
					if nowUsing != null:
						nowUsing.queue_free()
	if GameManager.instance.currentLevel == 0:
		is_first_add = true
	
	
func _get_mouse_world_pos():
	var vp = get_viewport()
	return vp.get_camera_2d().get_global_mouse_position()
	
	
