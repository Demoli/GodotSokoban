extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func clear_undo():
	for undo in get_tree().get_nodes_in_group("undoer"):
		undo.clear()
	
