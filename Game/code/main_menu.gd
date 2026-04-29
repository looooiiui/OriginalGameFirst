extends Node2D

@export var Save: Node2D
@export var Effect: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_signalConnect()
	GameManager.instance.windowsCount = 1
	GameManager.instance.currentLevel = 0
	Player.instance.input_Enable = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _first_test() -> void:
	pass


func _on_exit_pressed() -> void:
	get_tree().quit()

func _signalConnect() -> void:
	Save.startGame.connect(_onStartGame)

func _onStartGame() -> void:
	Effect.startGame()
	
