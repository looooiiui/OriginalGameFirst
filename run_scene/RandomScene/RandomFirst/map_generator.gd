extends Node2D

@export var RandomGround : TileMapLayer
@export var randomWorldX : int
@export var randomWorldY : int
@export var randomXMin : int = 200
@export var randomYMin : int = 200
@export var randomXMax : int = 300
@export var randomYMax : int = 300
@export var randomX : int
@export var randomY : int
@export var randomPicture : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomWorldX = randi_range(randomXMin, randomXMax)
	randomWorldY = randi_range(randomYMin, randomYMax)
	randomPicture = randi_range(0, 3)
	
	GameManager.instance.worldBoundaryXUp = randomWorldY
	GameManager.instance.worldBoundaryXDown = -randomWorldY
	GameManager.instance.worldBoundaryXLeft = -randomWorldX
	GameManager.instance.worldBoundaryXRight = randomWorldX
	
	for i in range(-randomWorldX, randomWorldX, 4):
		for j in range(-randomWorldY, randomWorldY, 4):
			randomX = randi_range(0, 0)
			randomY = randi_range(0, 0)
			randomPicture = randi_range(0, 3)
			RandomGround.set_cell(Vector2i(i, j), randomPicture, Vector2i(randomX, randomY))
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
