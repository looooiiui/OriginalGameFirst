extends Node2D

@export var _player_In: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_interaction()

func _interaction() -> void:
	if _player_In == true:
		if Input.is_action_just_pressed("open"):
			Player.instance.experience += 1000
			queue_free()

func _on_treasure_chest_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_player_In = true


func _on_treasure_chest_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_player_In = false
		
		
