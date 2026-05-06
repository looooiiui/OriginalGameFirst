class_name Grid

extends Node2D

static var instance : Grid

static var CELL_SIZE : int = 64

static var CELL_HELF : int = CELL_SIZE / 2

static func to_grid(world_pos: Vector2) -> Vector2i:
	return Vector2i(
		floor(world_pos.x / CELL_SIZE),
		floor(world_pos.y / CELL_SIZE)
	)

static func to_world(grid_pos: Vector2i) -> Vector2:
	return Vector2(grid_pos) * CELL_SIZE + Vector2(CELL_HELF, CELL_HELF)

static func snap(world_pos : Vector2) -> Vector2:
	return to_world(to_grid(world_pos))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Grid.instance == null:
		Grid.instance = self
	else:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
