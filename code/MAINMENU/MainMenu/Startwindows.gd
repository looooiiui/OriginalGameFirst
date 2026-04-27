extends Node2D

@export var windowsLerpSpeed: float = 10
#开始游戏菜单
@export var StartWindows : Window
#存档菜单
@export var ArchiveWindows: Window

var startWindowsX: int = 1200
var startWindowsY: int = 600

var archiveWindowsX: int = 400
var archiveWindowsY: int = 800

func _ready() -> void:
	#开始游戏菜单启动居中初始化
	StartWindows.popup_centered()
	StartWindows.visible = false
	#存档游戏菜单启动初始化
	ArchiveWindows.popup_centered()
	ArchiveWindows.visible = false
	
func _process(delta: float) -> void:
	_startWindowDisplay(delta)
	_archiveWindowDisplay(delta)


func _on_start_game_pressed() -> void:
	StartWindows.size.x = 2
	StartWindows.size.y = 1 
	StartWindows.visible = true
	
func _startWindowDisplay(delta: float) -> void:
	StartWindows.size.x = lerp(StartWindows.size.x, startWindowsX, windowsLerpSpeed * delta)
	StartWindows.size.y = lerp(StartWindows.size.y, startWindowsY, windowsLerpSpeed * delta)



func _on_archive_pressed() -> void:
	ArchiveWindows.size.x = 2
	ArchiveWindows.size.y = 1 
	ArchiveWindows.visible = true
	
func _archiveWindowDisplay(delta: float) -> void:
	ArchiveWindows.size.x = lerp(ArchiveWindows.size.x, archiveWindowsX, windowsLerpSpeed * delta)
	ArchiveWindows.size.y = lerp(ArchiveWindows.size.y, archiveWindowsY, windowsLerpSpeed * delta)
