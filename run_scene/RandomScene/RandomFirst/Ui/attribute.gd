extends Node2D

@export var _root: Node2D
@export var _Original_Monster_Manager: Node2D
@export var _Original_Monster:Node2D
@export var _CurrentLevel: Label
@export var _CurrentMonsterNum: Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_LevelUi_Display()
	
func _LevelUi_Display() -> void:
	_CurrentLevel.text = "当前波次: %d" % _Original_Monster_Manager._current_level
	_CurrentMonsterNum.text = "当前剩余怪物数量: %d" % _Original_Monster.current_Monster_Num
