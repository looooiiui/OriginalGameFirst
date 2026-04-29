extends Node2D

var tipStack = Stack.new()
@export var tipGroup: Dictionary[String, Node2D]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_tipInitialize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_gameTipRunning()

func _tipInitialize() -> void:
	tipStack.push(tipGroup.get("RUN", "NULL"))
	tipStack.push(tipGroup.get("WASD", "NULL"))
	tipStack.getTop().startTip()
	tipStack.getTop().visible = true
	
func _nextTip() -> void:
	var temp = tipStack.pop()
	if temp != null:
		temp.visible = false
		temp.resetTip()
	if tipStack.getTop() != null:
		tipStack.getTop().startTip()
		tipStack.getTop().visible = true

func _gameTipRunning() -> void:
	if tipStack.getTop() == null:
		queue_free()
		TeachingSystem.instance.isTip = false
		return
		
	if tipStack.getTop().isOver:
		_nextTip()
