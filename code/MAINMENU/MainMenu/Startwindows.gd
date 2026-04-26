extends Node2D

@export var StartWindows : Window
@export var startWindowsLerpSpeed: float = 6

var startWindowsX: int = 1200
var startWindowsY: int = 600
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StartWindows.popup_centered()
	StartWindows.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_startWindowDisplay(delta)


func _on_start_game_pressed() -> void:
	StartWindows.size.x = 2
	StartWindows.size.y = 1 
	StartWindows.visible = true
	
func _startWindowDisplay(delta: float) -> void:
	StartWindows.size.x = lerp(StartWindows.size.x, startWindowsX, startWindowsLerpSpeed * delta)
	StartWindows.size.y = lerp(StartWindows.size.y, startWindowsY, startWindowsLerpSpeed * delta)
