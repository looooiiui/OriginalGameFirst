extends Node2D

@export var _followSpeed: float = 6.0
@export var offset: Vector2 = Vector2(100, -100)
@export var isOver: bool = false
@export var isUp: bool = false
@export var isDown: bool = false
@export var isLeft: bool = false
@export var isRight: bool = false
#这里是显示的标签
@export var Up: Label
@export var Down: Label
@export var Left: Label
@export var Right: Label
@export var usedColor: Color = Color(0.0, 0.647, 0.0, 1.0)

func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_checkTipColor()
	_monitorTaskOver()
	_followPlayer(delta)

func _followPlayer(delta: float) -> void:
	var targetGlobalPosition = Player.instance.global_position + offset
	global_position = lerp(global_position, targetGlobalPosition, _followSpeed * delta)
	
func startTip() -> void:
	isOver = false
	isUp = false
	isDown = false
	isLeft = false
	isRight = false

func resetTip() -> void:
	isOver = false
	isUp = false
	isDown = false
	isLeft = false
	isRight = false
	
func _monitorTaskOver() -> void:
	if (Input.is_action_just_pressed("up")):
		isUp = true
	if (Input.is_action_just_pressed("down")):
		isDown = true	
	if (Input.is_action_just_pressed("left")):
		isLeft = true
	if (Input.is_action_just_pressed("right")):
		isRight = true
	if (isUp and isDown and isLeft and isRight):
		isOver = true

func _checkTipColor() -> void:
	if isUp:
		Up.modulate = usedColor
	else:
		Up.modulate = modulate
		
	if isDown:
		Down.modulate = usedColor
	else:
		Down.modulate = modulate	
		
	if isLeft:
		Left.modulate = usedColor
	else:
		Left.modulate = modulate
		
	if isRight:
		Right.modulate = usedColor
	else:
		Right.modulate = modulate
	
		
