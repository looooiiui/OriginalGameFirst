extends Window

@export var NodeWindows : Window
@export var offSet : Vector2i = Vector2i(1500, 238)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = offSet

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if NodeWindows.visible:
		visible = true
	else:
		visible = false
