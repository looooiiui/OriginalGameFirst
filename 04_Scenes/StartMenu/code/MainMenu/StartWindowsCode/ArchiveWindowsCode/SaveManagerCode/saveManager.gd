extends Node2D

@export var save1: Button
@export var save2: Button
@export var save3: Button

signal startGame()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_signalConnect()
	_saveChange()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _saveChange() -> void:
	if FileAccess.file_exists(SaveDataSystem.savePathFirst):
		save1.text = "Save01"
	else:
		save1.text = "NullOfSave"
		
	if FileAccess.file_exists(SaveDataSystem.savePathSecond):
		save2.text = "Save02"
	else:
		save2.text = "NullOfSave"
	
	if FileAccess.file_exists(SaveDataSystem.savePathThird):
		save3.text = "Save03"
	else:
		save3.text = "NullOfSave"

func _signalConnect() -> void:
	SaveDataSystem.instance.saveChange.connect(_onSaveChange)


func _onSaveChange() -> void:
	_saveChange()

func _on_save_first_pressed() -> void:
	SaveDataSystem.instance.UseSave(
		SaveDataSystem.instance.get_information(SaveDataSystem.instance.savePathFirst),
		SaveDataSystem.instance.savePathFirst
	)
	startGame.emit()

func _on_save_second_pressed() -> void:
	SaveDataSystem.instance.UseSave(
		SaveDataSystem.instance.get_information(SaveDataSystem.instance.savePathSecond),
		SaveDataSystem.instance.savePathSecond
	)
	startGame.emit()

func _on_save_third_pressed() -> void:
	SaveDataSystem.instance.UseSave(
		SaveDataSystem.instance.get_information(SaveDataSystem.instance.savePathThird),
		SaveDataSystem.instance.savePathThird
	)
	startGame.emit()
	
	
