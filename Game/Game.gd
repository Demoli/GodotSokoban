extends Node2D

var crates_placed = 0

func _ready():
	LevelManager.next()

func clear_undo():
	for undo in get_tree().get_nodes_in_group("undoer"):
		# reset undos then set the new initial state on all undoable objects
		undo.clear()
		if undo.get_parent().has_method("add_undo"):
			undo.get_parent().add_undo()
	
func _on_crate_placed(_target, _crate):
	crates_placed += 1
	if crates_placed == _get_total_crates():
		next_level()

func _on_crate_removed(_target, _crate):
	if crates_placed == _get_total_crates():
		next_level()

func _get_total_crates() -> int:
	return get_tree().get_nodes_in_group("crate").size()

func next_level():
	crates_placed = 0
	get_tree().call_group("undoer", "reset")
	
	LevelManager.next()


func _on_timeline_command_added(command: Command):
	match command.track:
		0: command.target = $Player
