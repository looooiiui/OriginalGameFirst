extends Node2D

@export var TreasureChest: PackedScene
@export var _Map_Generator: Node2D
@export var _Chest_Limited: int = 30
@export var _current_Chest_Num: int = 0
@export var _random_Generator_Magnification: int = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_Get_Current_Chest_Num()
	_GeneratorChest()

 
func _GeneratorChest() -> void:
	if _current_Chest_Num >= _Chest_Limited:
		return
		
	var tempX = _Map_Generator.randomXMax * _random_Generator_Magnification
	var tempY = _Map_Generator.randomYMax * _random_Generator_Magnification
	
	var random_Generator_X = randi_range(-tempX, tempX)
	var random_Generator_Y = randi_range(-tempY, tempY)
	
	var tempChest: Node2D = TreasureChest.instantiate()
	tempChest.global_position = Vector2(random_Generator_X, random_Generator_Y)
	add_child(tempChest)

func _Get_Current_Chest_Num() -> void:
	_current_Chest_Num = get_child_count()
