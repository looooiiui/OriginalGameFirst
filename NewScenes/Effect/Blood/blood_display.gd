extends Node2D

@export var BloodFather: CharacterBody2D
@export var _offset: Vector2
@export var _blood_Sprite: Sprite2D
@export var _blood_Follow_Speed: float = 5.0
@export var _blood_Change_Speed: float = 3.0
@export var _blood_Display_real: float
@export var _blood_Display_Length: float = 194

var _real_Blood_Display: float
func _ready() -> void:
	_Original_Initialization()
	_Father_Get()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_Blood_Display_Cal(delta)
	_Follow_Parent(delta)
	
func _Father_Get() -> void:
	BloodFather = get_parent()
	if (BloodFather == null):
		queue_free()
		
	global_position = BloodFather.global_position
	
func _Original_Initialization() -> void:
	_offset = Vector2(0, -100)
	_blood_Display_real = 0
	_real_Blood_Display = 0
		
func _Follow_Parent(delta: float) -> void:
	global_position = lerp(global_position, BloodFather.global_position + _offset, _blood_Follow_Speed * delta)
	
func _Blood_Display_Cal(delta: float) -> void:
	var ratio = BloodFather.currentHp / BloodFather._MaxHp
	ratio = clamp(ratio, 0.0, 1.0)

	_blood_Display_real = lerp(_blood_Display_real, _blood_Display_Length * ratio, _blood_Change_Speed * delta)
	_blood_Sprite.scale.x = _blood_Display_real
	
	
	
