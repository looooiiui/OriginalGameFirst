extends Node2D

@export var _followSpeed: float = 6.0
@export var offset: Vector2 = Vector2(100, -100)
@export var isOver: bool = false
@export var isRun: bool = false

func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_monitorTaskOver()
	_followPlayer(delta)

func _followPlayer(delta: float) -> void:
	var targetGlobalPosition = Player.instance.global_position + offset
	global_position = lerp(global_position, targetGlobalPosition, _followSpeed * delta)
	
func startTip() -> void:
	isOver = false
	isRun = false

func resetTip() -> void:
	isOver = false
	isRun = false
	
func _monitorTaskOver() -> void:
	if Input.is_action_just_pressed("run"):
		isOver = true
		
