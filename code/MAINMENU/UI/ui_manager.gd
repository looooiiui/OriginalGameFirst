extends Node2D

@export var MainLaber : AnimatedSprite2D
@export var mainSpriteRotate : float = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainLaber.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
