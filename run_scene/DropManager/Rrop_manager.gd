class_name drop_thing

extends Node2D

static var instance : drop_thing

@export var can_drop : bool = false
@export var drop_maxLimited : int = 1
@export var drop_current : int = 0
@export var take_range : float = 64




@export var temp : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if instance == null:
		instance = self
	else:
		queue_free()
	
	
	can_drop = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	_can_drop_detect()
	
	if can_drop:
		_drop_append()
	
	
	
	
func _can_drop_detect():
	if GameManager.instance.currentLevel != 0 and !can_drop:
		can_drop = true
		drop_current = 0
	elif GameManager.instance.currentLevel == 0 and can_drop:
		can_drop = false
		drop_current = 0		
		
func _drop_append():
	if drop_current < drop_maxLimited:
		var inst = temp.instantiate()
		get_tree().current_scene.add_child(inst)
		drop_current += 1
			
func _stop_game():
	drop_current = 0
