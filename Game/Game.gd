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
	LevelManager.load_level()

	var commands = get_tree().get_first_node_in_group("timeline").commands
	for c in commands:
		_on_timeline_command_added(c)
	
func next_level():
	GlobalData.level += 1
	var timeline = get_tree().get_first_node_in_group("timeline")
	timeline.stop()
	timeline.reset()
	load_level()

func _on_timeline_command_added(command: Command):
	match command.track:
		0: command.target = $PlayerGreen
		1: command.target = $PlayerRed

func _on_win_timer_timeout():
	if crates_placed == _get_total_crates():
		next_level()
