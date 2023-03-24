extends Node2D

var crates_placed = 0

func _ready():
	GlobalData.level += 1
	load_level()
	$WinTimer.start()

func _process(delta):
	if Input.is_action_just_pressed("stop"):
		# reload the level
		load_level()

func clear_undo():
	for undo in get_tree().get_nodes_in_group("undoer"):
		# reset undos then set the new initial state on all undoable objects
		undo.clear()
		if undo.get_parent().has_method("add_undo"):
			undo.get_parent().add_undo()
	
func _on_crate_placed(_target, _crate):
	crates_placed += 1
	crates_placed = clamp(crates_placed, 0, _get_total_crates())

func _on_crate_removed(_target, _crate):
	crates_placed -= 1
	crates_placed = clamp(crates_placed, 0, _get_total_crates())

func _get_total_crates() -> int:
	return get_tree().get_nodes_in_group("crate").size()

func load_level():
	crates_placed = 0
	get_tree().call_group("undoer", "reset")
	LevelManager.load_level()

	var commands = $CanvasLayer/Timeline.commands
	for c in commands:
		_on_timeline_command_added(c)
	
func next_level():
	GlobalData.level += 1
	$CanvasLayer/Timeline.stop()
	$CanvasLayer/Timeline.reset()
	load_level()

func _on_timeline_command_added(command: Command):
	match command.track:
		0: command.target = $PlayerGreen
		1: command.target = $PlayerRed

func _on_win_timer_timeout():
	if crates_placed == _get_total_crates():
		next_level()
