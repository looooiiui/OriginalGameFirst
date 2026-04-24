extends Node2D

@export var AttackMag: Label
@export var CoolMag: Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_Attribute_Display()

func _Attribute_Display() -> void:
	AttackMag.text = "当前伤害倍率: %.1f" % Player.instance.allCoolTime_Mag
	CoolMag.text   = "当前冷却倍率: %.1f" % Player.instance.allCoolTime_Mag
