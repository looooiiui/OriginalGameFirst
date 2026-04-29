extends Node2D

@export var InLevel: Sprite2D
@export var LevelUi: Label
@export var level_Lerp_Speed = 8.0
@export var ui_Lerp_Speed = 8.0

var level_Ui_Current_Experience: float = 0.0
var tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_Initialization_tween()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_Level_Display(delta)
	_update_Level_Ui(delta)

func _Initialization_tween() -> void:
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_loops()
	
	tween.tween_property(
			InLevel,
			"modulate",
			Color(0.438, 0.239, 0.153, 1.0),
			1.0
		)
	tween.tween_property(
			InLevel,
			"modulate",
			Color(0.624, 0.196, 0.078, 1.0),
			1.0
		)
	
func _Level_Display(delta: float) -> void:
	var player_Experience_radio: float = Player.instance.experience / Player.instance.maxExperience
	player_Experience_radio = clamp(player_Experience_radio, 0.0, 1.0)
	
	var target_width = 1014.0 * player_Experience_radio
	var target_scale = Vector2(target_width, 22.313)
	
	InLevel.scale = lerp(InLevel.scale, target_scale, level_Lerp_Speed * delta)
	
func _update_Level_Ui(delta: float) -> void:
	level_Ui_Current_Experience = lerp(
		level_Ui_Current_Experience, 
		Player.instance.experience, 
		ui_Lerp_Speed * delta
	)
	
	LevelUi.text = (
		"PlayerLevel: %d    " % Player.instance.level +
		"NeedExp: %.1f    " % Player.instance.maxExperience +
		"Experience: %.1f    " % level_Ui_Current_Experience
	)
	
	
	
	
	
