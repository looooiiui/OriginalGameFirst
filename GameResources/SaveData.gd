extends Node
class_name SaveDataSystem

static var mutex: Mutex = Mutex.new()
static var _instance: SaveDataSystem

func _ready() -> void:
	_instance_initialize()

func _process(delta: float) -> void:
	pass
	
	
#单例双锁，初始化一次
func _instance_initialize() -> void:
	if _instance == null:
		mutex.lock()
		if _instance == null:
			_instance = self
		mutex.unlock()
		
func _save_information_first() -> void:
	var config: ConfigFile = ConfigFile.new()
	_set_information(config)
	config.save("user://SaveFirst.cfg")
	
	
func _get_information_first() -> void:
	var config: ConfigFile = ConfigFile.new()
	var result = config.load("user://SaveFirst.cfg")
	
	if result == OK:
		print(config.get_value("Player", "global_position"))
		
func _set_information(config: ConfigFile) -> void:
	config.set_value("Player", "global_position", Player.instance.global_position)
	config.set_value("Player", "level", Player.instance.level)
	config.set_value("Player", "experience", Player.instance.experience)
	config.set_value("Player", "real_hp", Player.instance.real_hp)
	config.set_value("Player", "now_Arm_select", Player.instance.now_Arm_select)
	config.set_value("Player", "magic_Point", Player.instance.magic_Point)
	config.set_value("Player", "attackDamageMag", Player.instance.attackDamageMag)
	config.set_value("Player", "defense_Mag", Player.instance.defense_Mag)
	config.set_value("Player", "magic_Attack_Mag", Player.instance.magic_Attack_Mag)
	config.set_value("Player", "magic_defense_Mag", Player.instance.magic_defense_Mag)
	config.set_value("Player", "dexterity_Mag", Player.instance.dexterity_Mag)
	config.set_value("Player", "strength_Mag", Player.instance.strength_Mag)	
	config.set_value("Player", "intelligence_Mag", Player.instance.intelligence_Magn)	
	config.set_value("Player", "vitality_Mag", Player.instance.vitality_Mag)
	config.set_value("Player", "allCoolTime_Magn", Player.instance.allCoolTime_Mag)
