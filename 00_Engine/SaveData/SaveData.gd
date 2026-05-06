extends Node

#这里定义全局存档系统的类名，用于访问
class_name SaveDataSystem
#这个是保存系统单例
static var instance: SaveDataSystem

static var savePathFirst: String = "user://Save01.json"
static var savePathSecond: String = "user://Save02.json"
static var savePathThird: String = "user://Save03.json"

signal saveChange()

func _init() -> void:
	_instance_initialize()

func _instance_initialize() -> void:
	if instance == null:
		instance = self
	else:
		queue_free()

#保存存档数据(使用json保存)
func set_information(filePath: String) -> void:
	var player_dict: Dictionary = {
			"Player": {
				"global_position": var_to_str(Player.instance.global_position),
				"level": Player.instance.level,
				"experience": Player.instance.experience,
				"real_hp": Player.instance.real_hp,
				"now_Arm_select": Player.instance.now_Arm_select,
				"magic_Point": Player.instance.magic_Point,
				"attackDamageMag": Player.instance.attackDamageMag,
				"defense_Mag": Player.instance.defense_Mag,
				"magic_Attack_Mag": Player.instance.magic_Attack_Mag,
				"magic_defense_Mag": Player.instance.magic_defense_Mag,
				"dexterity_Mag": Player.instance.dexterity_Mag,
				"strength_Mag": Player.instance.strength_Mag,
				"intelligence_Mag": Player.instance.intelligence_Mag,
				"vitality_Mag": Player.instance.vitality_Mag,
				"allCoolTime_Magn": Player.instance.allCoolTime_Mag
			}
		}
	var json_str = JSON.stringify(player_dict, " ")
	var file = FileAccess.open(filePath, FileAccess.WRITE)
	if file:
		file.store_string(json_str)
		file.close()
	SaveDataSystem.instance.saveChange.emit()
	
#获得存档信息(字典返回值)
func get_information(filePath: String) -> Dictionary:
	
	#如果文件不存在，就直接返回空字典
	if !FileAccess.file_exists(filePath):
		return {}
		
	#打开文件
	var file = FileAccess.open(filePath, FileAccess.READ)
	#将文件内的数据以字符串的形式读入，注意不是直接读入字典
	var tempText = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	##这里parse()函数负责解析String，解析完后的数据在json中
	##这里解析完后, json.data 就是字典
	json.parse(tempText)
	
	SaveDataSystem.instance.saveChange.emit()
	#返回解析后得到的字典
	return json.data as Dictionary

#删除存档信息 
func deleteInformation(filePath: String) -> void:
	if FileAccess.file_exists(filePath):
		DirAccess.remove_absolute(filePath)
	SaveDataSystem.instance.saveChange.emit()
	
func UseSave(saveDict: Dictionary, filePath: String) -> void:
	if (saveDict.is_empty()):
		set_information(filePath)
		return
	var saveDic: Dictionary = saveDict.get("Player", {})
	
	Player.instance.global_position = str_to_var(saveDic.get("global_position", Vector2(0, 0)))
	Player.instance.level = saveDic.get("level", 1)
	Player.instance.experience = saveDic.get("experience", 0)
	Player.instance.real_hp = saveDic.get("real_hp", Player.instance.max_hp)
	Player.instance.now_Arm_select = saveDic.get("now_Arm_select", 0)
	Player.instance.magic_Point = saveDic.get("magic_Point", Player.instance.max_Magic_Point)
	Player.instance.attackDamageMag = saveDic.get("attackDamageMag", 1)
	Player.instance.defense_Mag	= saveDic.get("defense_Mag", 1)
	Player.instance.magic_Attack_Mag = saveDic.get("magic_Attack_Mag", 1)
	Player.instance.magic_defense_Mag = saveDic.get("magic_defense_Mag", 1)
	Player.instance.dexterity_Mag = saveDic.get("dexterity_Mag", 1)
	Player.instance.strength_Mag = saveDic.get("strength_Mag", 1)
	Player.instance.intelligence_Mag = saveDic.get("intelligence_Mag", 1)
	Player.instance.vitality_Mag = saveDic.get("vitality_Mag", 1)
	Player.instance.allCoolTime_Mag = saveDic.get("allCoolTime_Mag", 1)
	
	
