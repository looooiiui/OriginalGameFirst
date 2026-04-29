extends Node2D

@export var MeleeTime : Timer
@export var damage : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage = Player.instance.meleeDamage
	MeleeTime.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = Player.instance.global_position
	global_rotation = Player.instance.global_rotation
	if MeleeTime.is_stopped():
		queue_free()
