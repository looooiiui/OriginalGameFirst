extends Node2D

@export var MouseHit : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_Hit_effect = MouseHit.instantiate()
		mouse_Hit_effect.get_GlobalPosition(get_global_mouse_position())
		add_child(mouse_Hit_effect)
	
