extends Node2D

@export var Original_Monster: Array[PackedScene]
@export var spawn_Node: Node2D
@export var current_Level_Monster_Limited : int = 10
var current_Monster_Num : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func General_Monster_Test() -> void:
	if current_Monster_Num < current_Level_Monster_Limited:
		current_Monster_Num += 1
		var temp : Node2D = Original_Monster[0].instantiate()
		temp.global_position = Vector2(100, -500)
		spawn_Node.add_child(temp)
		
	
