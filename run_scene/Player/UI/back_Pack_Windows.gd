extends Window

@export var Back_row : Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func check_empty(newId : String):
	for i in Back_row.size():
		for j in Back_row[i].Raw.size():
			if Back_row[i].Raw[j].selectId == "":
				Back_row[i].Raw[j].selectId = newId
				return
