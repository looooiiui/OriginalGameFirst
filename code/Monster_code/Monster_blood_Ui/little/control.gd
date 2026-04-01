extends Control

@export var Monster : Area2D
@export var Sprite : Sprite2D
@export var smooth : float = 0.1
@export var Blood_sprite : Sprite2D
@export var blood_high : float = 1.14 #hp头顶比例
@export var offset : Vector2 = Vector2(-50, 0)

#内部控制(专属控制不用特别计算公式)
var final_offset : Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = Blood_sprite.global_position + offset
	#血条位置自动调整
	if Sprite != null and Sprite.texture != null:
		var real_high = Sprite.texture.get_height() * abs(Sprite.scale.y)
		final_offset = offset + Vector2.UP * (real_high / blood_high)
	else:
		final_offset = offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = lerp(global_position, Blood_sprite.global_position + final_offset, smooth)
	
