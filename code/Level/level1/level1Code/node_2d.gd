extends Node2D

@export var MonsterKind : Array[PackedScene]
@export var CurrentLevel : int = 1
@export var monster_all_num : int = 10
@export var monster_real_num : int = 0
@export var worldBoundaryXLeft : float = -1000
@export var worldBoundaryXRight : float = 3040
@export var worldBoundaryXUp : float = -3050
@export var worldBoundaryXDown : float = 940

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player.input_Enable = true
	GameManager.instance.windowsCount = 0
	GameManager.instance.worldBoundaryXLeft = worldBoundaryXLeft
	GameManager.instance.worldBoundaryXRight = worldBoundaryXRight
	GameManager.instance.worldBoundaryXUp = worldBoundaryXUp
	GameManager.instance.worldBoundaryXDown = worldBoundaryXDown
	GameManager.instance.currentLevel = CurrentLevel
	
	Player.instance.global_position = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	monster_first_occ()
	
	

func monster_first_occ():
	if monster_real_num < monster_all_num:
		var random_Monster = randi_range(0, MonsterKind.size() - 1)
		var Monster = MonsterKind[random_Monster].instantiate()
		var random_x = randi_range(worldBoundaryXLeft, worldBoundaryXRight)
		var random_y = randi_range(worldBoundaryXDown, worldBoundaryXUp)
		
		Monster.change_Global_Position(-100, -100)
	#	Monster.change_Global_Position(random_x, random_y)
		$%MonsterNum.add_child(Monster)
		
	monster_real_num = $%MonsterNum.get_child_count()
	GameManager.instance.monster_real_num = monster_real_num
	GameManager.instance.monster_all_num = monster_all_num
