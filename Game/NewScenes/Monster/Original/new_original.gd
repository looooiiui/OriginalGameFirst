extends CharacterBody2D

@export var _agent: NavigationAgent2D
@export var _Original_Move_Speed: float = 200
@export var _MaxHp: float = 100
@export var currentHp: float = 0
@export var is_dead: bool = false
@export var damage: float = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_originalnewOriginal()
	_agent.target_position = Vector2(500, 500)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_Follow_Player()
	_Original_Move(delta)
	_Dead_state()
	
func _Original_Move(delta: float) -> void:
	var nextPos = _agent.get_next_path_position()
	var dir = global_position.direction_to(nextPos)
	
	velocity = dir * _Original_Move_Speed
	move_and_slide()
	
func _Follow_Player() -> void:
	_agent.target_position = Player.instance.global_position
	
	
func _originalnewOriginal() -> void:
	currentHp = _MaxHp


func _on_new_original_hit_area_entered(area: Area2D) -> void:
	if area.is_in_group("Attack"):
		currentHp -= area.damage
		
func _Dead_state() -> void:
	if is_dead:
		Player.instance.experience += 20
		Player.instance.real_hp += 5
		queue_free()
		



func _on_new_original_hit_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Player.instance.took_damage(10)
