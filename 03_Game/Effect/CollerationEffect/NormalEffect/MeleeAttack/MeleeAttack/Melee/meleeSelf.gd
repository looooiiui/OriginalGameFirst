extends Area2D

@export var damage : float
@export var NodeUp : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage = Player.instance.meleeDamage


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
