## 注意，这里只是完整代码， 下文会拆开讲
## 放在这里方便解释完后回来总体再加深一遍理解
## 这里包含三层完整交互

extends Node2D

# 枚举类型，表示物品栏的类型(四格主物品栏，背包栏，装备栏),注意这里没有装备栏
enum TheMainType {MAINARM, BACKMENT, EQUIMENT}

# 这里定义的type是用来表示当前物品栏格子的枚举属性(属于哪一类)
@export var type : TheMainType

# 这个是物品栏本身背景板，不是物品贴图
@export var Back : Sprite2D

# 这个是物品栏本身的贴图样式，也就是物品栏的框的样子，不是物品贴图
@export var Inventory : Sprite2D

# 这个是物品栏当前存的物品ID
@export var selectId : String = ""

# 这个是用来存放当前物品栏物品贴图的，通过更改Sprite2D的Texture属性来更改贴图
@export var case : Sprite2D

# 如果有值，则这个变量表示当前物品栏的图标与指定的物品栏同步，并且此物品栏将无法操作
@export var Follow_Case : Node2D

# 这个存放的是所有物品栏的总根节点
@export var BackPack : Node2D

# 这个存放的是物品栏没变色前的颜色，用于鼠标离开当前物品栏后变回原色
@export var originalColor : Color

# 这个存放的是鼠标悬停时物品栏要变的颜色
@export var selectColor : Color = Color(0.148, 0.773, 0.953, 0.5)

# 这个表示当前物品栏的物品是否被鼠标拿起，是用来表示本物品栏贴图是否跟随鼠标的
@export var is_Case_Taken : bool = false

# 这个用来控制鼠标进入物品栏时候，物品栏检测的范围
@export var selectOffset : float = 0.5

# 这个用来表示鼠标是否在当前物品栏内
var is_Mouse_Inside : bool = false

func _ready() -> void:
	# 物品栏第一次加载获取原色
	originalColor = modulate
	
	case.z_index = 99;
	
	# 物品栏第一次加载即换入一次对应ID的图标
	change_case_icon()

# 每一帧执行一次
func _process(delta: float) -> void:
	
	# 这里是物品栏同步的逻辑，获取同步的物品栏的物品ID，图像由表现层更新
	if Follow_Case:
		selectId = Follow_Case.selectId
	
	# 这里是三个下面写好的函数	
	_mouse_Inside_Light()
	change_case_icon()
	_follow_Mouse()

# 这里是改变贴图的函数
func change_case_icon():
	## CaseIcon是刚刚的全局物品数据库单例
	
	# 判断ID是否在武器数据库存在
	if selectId in CaseIcon.instance.ArmIcon.idToIcon:
		case.texture = CaseIcon.instance.ArmIcon.idToIcon[selectId]
	
	# 判断ID是否在物品数据库中存在
	elif selectId in CaseIcon.instance.Case.idToIcon:
		case.texture = CaseIcon.instance.Case.idToIcon[selectId]
	
	# 不存在引用空贴图(空贴图是制作的时候自己给定的)
	elif selectId != "":
		case.texture = CaseIcon.instance.Case.idToIcon["null"]
	
	# 如果是空ID则将贴图置空
	else:
		case.texture = null

## 这里用视口坐标来判断鼠标的操作
## _input(event): 是Godot内置事件函数，用来获得当前的各种输入(键盘鼠标)
func _input(event):
	var mouse = get_viewport().get_mouse_position()
	
	# 检测左键是否点击
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		
		# 判断鼠标是否在当前物品栏内
		if _mouse_Inside():	
			if !MainArm.instance.is_Case_Taken and event.is_pressed():
				
				# 存入当前物品栏的物品ID
				MainArm.instance.dragging_Id = selectId
				
				# 存入物品栏自己，方便在另一个物品栏交换ID的时候直接取得被拿物品栏格子
				MainArm.instance.dragging_Slot = self
				
				# 标记全局当前有物品被拿
				MainArm.instance.is_Case_Taken = true
				is_Case_Taken = true
			

			elif (MainArm.instance.is_Case_Taken and event.is_pressed()):	
				# 存入当前物品栏ID
				var temp = selectId
				
				# 将被先前被拿起的物品栏的ID取过来
				selectId = MainArm.instance.dragging_Id
				
				# 将原本这个物品的ID赋值给被拿起物品的物品栏
				MainArm.instance.dragging_Slot.selectId = temp
				
				# 标记已经交换完成，全局物品没有给拿起
				MainArm.instance.is_Case_Taken = false
				
				# 这里将之前被拿起物品的物品栏的物品贴图跟随关闭，使物品贴图回到物品栏
				MainArm.instance.dragging_Slot.is_Case_Taken = false
				
				# 将被全局标记拿起的物品栏置空
				MainArm.instance.dragging_Slot = null
				
				# 将被临时存储的ID置空
				MainArm.instance.dragging_Id = ""	
	
# 这里是鼠标悬停高亮物品栏代码
func _mouse_Inside_Light():
	
	#如果鼠标入内，则物品栏变色(modulate属性)
	if _mouse_Inside():
		modulate = selectColor
	else:
		modulate = originalColor
	
# 这里是判断鼠标入内的代码
func _mouse_Inside() -> bool:
	
	#获取当前视口系(一般来说是屏幕)的鼠标位置(坐标系在总架构细分里讲过，可以跳转回主文章阅览)
	var mouse = get_viewport().get_mouse_position()
	
	## 这里获得的是全局坐标的坐标位置，但是这里的全局位置已经被当前物品栏节点的根节点(windows节点)更改
	## 所以这里获得的是以当前弹出的背包的窗口的左上角为原点的全局坐标系位置
	## 而这里的窗口是显示在当前屏幕视口上的，不会相对屏幕偏移
	## 故当前获得的是当前物品栏背景板中心点(这里是轴心)在屏幕上的位置
	## get_origin()就是得到坐标系矩阵中VectorX位置，这里是Vector2位置。
	## 具体详细坐标系变换Transform仍然会在主架构中更新
	var local = Back.get_global_transform().get_origin()
	
	## 这里规定了鼠标进入物品栏检测的范围
	## 中心点的上下左右各加入当前 背景板的长度大小 * 缩放的比例 * 一半(也就是中心点加一半长度)
	var left = local.x - Back.texture.get_width() * Back.scale.x * selectOffset
	var right = local.x + Back.texture.get_width() * Back.scale.x * selectOffset 
	var up = local.y + Back.texture.get_height() * Back.scale.y * selectOffset
	var down = local.y - Back.texture.get_height() * Back.scale.y * selectOffset
	
	# 在范围内则返回true
	if mouse.x > left and mouse.x < right:
		if mouse.y > down and mouse.y < up:
			if BackPack.is_BackPack_Visible:
				return true
	return false
				
# 这里是当前物品栏对应的物品贴图跟随鼠标的代码
func _follow_Mouse():	
	
	#鼠标在屏幕上的位置
	var mouse = get_viewport().get_mouse_position()
	
	##如果内置的被拿变量is_Case_Taken是true,也就是当前物品栏正在被拿，则控制贴图的位置与鼠标对齐
	##这里使用全局变换坐标的解释同上
	if is_Case_Taken:
		case.global_transform.origin = mouse
	else:
		case.transform.origin = Back.transform.origin
		
