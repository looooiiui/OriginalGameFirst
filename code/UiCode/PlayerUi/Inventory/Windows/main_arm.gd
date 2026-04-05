class_name MainArm

extends Node2D

static var instance : MainArm

@export var armInventory : Array[Node2D]
@export var dragging_Slot : Node2D
@export var dragging_Id : String = ""
@export var is_Case_Taken : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	armInventory[0].selectId = ""
	armInventory[1].selectId = "00001C"
	armInventory[2].selectId = "00002C"
	armInventory[3].selectId = ""
	if MainArm.instance == null:
		MainArm.instance = self
	else:
		queue_free()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.		
func _process(delta: float) -> void:
	_quit_case()
	
func _quit_case():
	if Input.is_action_just_pressed("drop"):
		if armInventory[PlayerUI.instance.currentSelect].selectId != "":
			if armInventory[PlayerUI.instance.currentSelect].selectId.length() >= 6 and armInventory[PlayerUI.instance.currentSelect].selectId[5] == "G":
				armInventory[PlayerUI.instance.currentSelect].selectId = ""
				print(armInventory[PlayerUI.instance.currentSelect].selectId)
