extends Node2D

enum TheMainType {MAINARM, BACKMENT, EQUIMENT}

@export var type : TheMainType
@export var Back : Sprite2D
@export var Inventory : Sprite2D
@export var selectId : String = ""
@export var case : Sprite2D
@export var Follow_Case : Node2D
@export var UI : CanvasLayer
@export var BackPack : Node2D
@export var originalColor : Color
@export var selectColor : Color = Color(0.148, 0.773, 0.953, 0.5)
@export var is_Case_Taken : bool = false
@export var selectOffset : float = 0.5
var is_Mouse_Inside : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	originalColor = modulate
	change_case_icon()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Follow_Case:
		selectId = Follow_Case.selectId
		
	
	_mouse_Inside_Light()
	change_case_icon()
	_follow_Mouse()
	
func change_case_icon():
	if selectId in CaseIcon.instance.ArmIcon.idToIcon:
		case.texture = CaseIcon.instance.ArmIcon.idToIcon[selectId]
	elif selectId != "":
		case.texture = CaseIcon.instance.Case.idToIcon["null"]
	else:
		case.texture = null
	
	if selectId in CaseIcon.instance.Case.idToIcon:
		case.texture = CaseIcon.instance.Case.idToIcon[selectId]
	elif selectId != "":
		case.texture = CaseIcon.instance.Case.idToIcon["null"]
	else:
		case.texture = null

func _input(event):
	var mouse = get_viewport().get_mouse_position()
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if _mouse_Inside():	
			if event.pressed:
				if event.pressed:
					if !MainArm.instance.is_Case_Taken:
						MainArm.instance.dragging_Id = selectId
						MainArm.instance.dragging_Slot = self
						MainArm.instance.is_Case_Taken = true
						is_Case_Taken = true
			
	
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if _mouse_Inside():
			if !event.pressed:
				if MainArm.instance.is_Case_Taken:
					var temp = selectId
					selectId = MainArm.instance.dragging_Id
					MainArm.instance.dragging_Slot.selectId = temp
					
					MainArm.instance.is_Case_Taken = false
					MainArm.instance.dragging_Slot.is_Case_Taken = false
					MainArm.instance.dragging_Slot = null
					MainArm.instance.dragging_Id = ""	
	
	
func _mouse_Inside_Light():
	if _mouse_Inside():
		modulate = selectColor
	else:
		modulate = originalColor	
	
#判断鼠标入内	
func _mouse_Inside() -> bool:
	var mouse = get_viewport().get_mouse_position()
	var local = Back.get_global_transform().get_origin()
	
	var left = local.x - Back.texture.get_width() * Back.scale.x * selectOffset
	var right = local.x + Back.texture.get_width() * Back.scale.x * selectOffset 
	var up = local.y + Back.texture.get_height() * Back.scale.y * selectOffset
	var down = local.y - Back.texture.get_height() * Back.scale.y * selectOffset
	
	if mouse.x > left and mouse.x < right:
		if mouse.y > down and mouse.y < up:
			if BackPack.is_BackPack_Visible:
				return true
	return false
				
		
func _follow_Mouse():	
	var mouse = get_viewport().get_mouse_position()
	if is_Case_Taken:
		case.global_transform.origin = mouse
	else:
		case.transform.origin = Back.transform.origin
