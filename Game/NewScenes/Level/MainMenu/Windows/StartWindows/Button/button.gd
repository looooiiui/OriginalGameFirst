extends Node2D

@export var TipButton: CheckButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	TipButton.is_hovered()



func _on_tip_button_toggled(toggled_on: bool) -> void:
	TeachingSystem.instance.isTip = toggled_on
