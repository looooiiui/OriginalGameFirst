class_name CaseIcon

extends Node2D

static var instance : CaseIcon

@export var InstanceManager : Node2D
@export var ArmIcon : Node2D
@export var Case : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if CaseIcon.instance == null:
		CaseIcon.instance = self
	else:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
