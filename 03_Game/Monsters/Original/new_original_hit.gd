extends Area2D

@export var _Main_Node: CharacterBody2D
@export var is_dead: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_Dead_Judge()
	_Follow_Node()

func _Follow_Node() -> void:
	_Main_Node.is_dead = is_dead
	
func _Dead_Judge() -> void:
	if _Main_Node.currentHp <= 0:
		is_dead = true
