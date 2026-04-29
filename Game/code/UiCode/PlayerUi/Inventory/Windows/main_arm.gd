class_name MainArm

extends Node2D

##这里就是当前主物品栏的单例
## 下面四个@export在上文格子代码中被使用
static var instance : MainArm

# 主管理器的4个格子放一个数组里面
@export var armInventory : Array[Node2D]

# 用来临时保存被拖动的物品贴图的物品栏
@export var dragging_Slot : Node2D

# 用来保存被拖动的物品栏里面存的ID
@export var dragging_Id : String = ""

# 用来标局全局物品栏是否有物品被拿起
@export var is_Case_Taken : bool = false


func _ready() -> void:
	
	# 这里用来给四个主物品栏赋初值，通过表现层直接展示对应物品贴图
	armInventory[0].selectId = ""
	armInventory[1].selectId = "10000G"
	armInventory[2].selectId = ""
	armInventory[3].selectId = ""
	
	# 这里是单例手写模式
	if MainArm.instance == null:
		MainArm.instance = self
	else:
		queue_free()
		
			
func _process(delta: float) -> void:
	_quit_case()

# 这里是用来执行玩家丢弃逻辑的，不是本文重点
func _quit_case():
	if Input.is_action_just_pressed("drop"):
		if armInventory[PlayerUI.instance.currentSelect].selectId != "":
			if armInventory[PlayerUI.instance.currentSelect].selectId.length() >= 6 and armInventory[PlayerUI.instance.currentSelect].selectId[5] == "G":
				armInventory[PlayerUI.instance.currentSelect].selectId = ""
				print(armInventory[PlayerUI.instance.currentSelect].selectId)
