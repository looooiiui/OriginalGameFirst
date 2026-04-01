extends Node2D

@export var StartWindows : Window
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StartWindows.popup_centered()
	StartWindows.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	StartWindows.visible = true
