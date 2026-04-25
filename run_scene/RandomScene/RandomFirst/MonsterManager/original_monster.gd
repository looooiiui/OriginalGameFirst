extends Node2D

@export var Original_Monster: Array[PackedScene]
@export var spawn_Node: Node2D
@export var current_Level_Monster_Limited : int = 10
@export var _Map_Generator: Node2D
@export var _random_Generator_Magnification: float = 4
@export var _generator_Over: bool = false
var current_Monster_Num : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	General_Monster_Test()
	_Monster_Num_Cal()

func General_Monster_Test() -> void:
	var tempX = _Map_Generator.randomXMax * _random_Generator_Magnification
	var tempY = _Map_Generator.randomYMax * _random_Generator_Magnification
	
	var random_Generator_X = randi_range(-tempX, tempX)
	var random_Generator_Y = randi_range(-tempY, tempY)
	
	if current_Monster_Num < current_Level_Monster_Limited and !_generator_Over:
		var temp : Node2D = Original_Monster[0].instantiate()
		temp.global_position = Vector2(random_Generator_X, random_Generator_Y)
		spawn_Node.add_child(temp)
		_Monster_Num_Cal()
	
	if current_Monster_Num == current_Level_Monster_Limited:
		_generator_Over = true
	
	if current_Monster_Num == 0:
		get_parent()._current_level += 1
		current_Level_Monster_Limited += 3
		_generator_Over = false
		
func _Monster_Num_Cal() -> void:
	current_Monster_Num = get_node("Monsters").get_child_count()
	
	
