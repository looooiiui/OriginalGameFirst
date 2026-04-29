extends Node2D

@export var save1: Button
@export var save2: Button
@export var save3: Button

func _ready() -> void:
	_saveChange()
	_signalConnect()

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


func _on_save_1_pressed() -> void:
	SaveDataSystem.instance.set_information(SaveDataSystem.savePathFirst)

func _on_save_2_pressed() -> void:
	SaveDataSystem.instance.set_information(SaveDataSystem.savePathSecond)

func _on_save_3_pressed() -> void:
	SaveDataSystem.instance.set_information(SaveDataSystem.savePathThird)


func _on_delete_1_pressed() -> void:
	SaveDataSystem.instance.deleteInformation(SaveDataSystem.instance.savePathFirst)

func _on_delete_2_pressed() -> void:
	SaveDataSystem.instance.deleteInformation(SaveDataSystem.instance.savePathSecond)


func _on_delete_3_pressed() -> void:
	SaveDataSystem.instance.deleteInformation(SaveDataSystem.instance.savePathThird)
	
func _signalConnect() -> void:
	SaveDataSystem.instance.saveChange.connect(_onSaveChange)

func _onSaveChange() -> void:
	_saveChange()
