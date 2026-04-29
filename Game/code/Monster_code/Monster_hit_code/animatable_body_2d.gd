extends AnimatableBody2D

@export var Monster : Area2D
@export var offset : Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not Monster.is_dead:
		position = offset
	if Monster.Dead_Time.time_left <= 1.001 and Monster.is_dead:
		queue_free()
