extends Node2D


@export var PlayerDeadEffect : GPUParticles2D
@export var DeadEffectPlayTime : Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerDeadEffect.restart()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if DeadEffectPlayTime.is_stopped():
		queue_free()
