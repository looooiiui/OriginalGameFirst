extends CharacterBody2D

@export var _agent: NavigationAgent2D
@export var _Original_Move_Speed: float = 200
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_agent.target_position = Vector2(500, 500)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_Follow_Player()
	_Original_Move(delta)
	
func _Original_Move(delta: float) -> void:
	var nextPos = _agent.get_next_path_position()
	var dir = global_position.direction_to(nextPos)
	
	velocity = dir * _Original_Move_Speed
	move_and_slide()
	
func _Follow_Player() -> void:
	_agent.target_position = Player.instance.global_position
	
	
