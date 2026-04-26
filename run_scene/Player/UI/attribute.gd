extends Node2D

@export var CurrentHp: Label
@export var AttackMag: Label
@export var CoolMag: Label
@export var DefenseMag: Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_Attribute_Display()
	_playerAttributeDisplay()

func _Attribute_Display() -> void:
	AttackMag.text  = "当前伤害倍率: %.1f" % Player.instance.attackDamageMag
	CoolMag.text    = "当前冷却倍率: %.1f" % Player.instance.allCoolTime_Mag
	DefenseMag.text = "当前防御倍率: %.1f" % Player.instance.defense_Mag
	
func _playerAttributeDisplay() -> void:
	CurrentHp.text  = "当前血量: %.1f" % Player.instance.real_hp
