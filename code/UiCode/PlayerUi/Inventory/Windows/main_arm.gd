class_name MainArm

extends Node2D

static var instance : MainArm

@export var armInventory : Array[Node2D]
@export var dragging_Slot : Node2D
@export var dragging_Id : String = ""
@export var is_Case_Taken : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	armInventory[0].selectId = "10000G"
	armInventory[1].selectId = "00001C"
	if MainArm.instance == null:
		MainArm.instance = self
	else:
		queue_free()
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
