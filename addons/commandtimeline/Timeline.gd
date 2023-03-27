class_name Timeline
extends BoxContainer

## Timeline node
##
## A timeline control that can accept be played, paused and reset.
## Command objects can be added to the timeline and will execute when the timeline reaches that time.[br]
##

signal command_added

func _ready():
	add_to_group("timeline")

func add_command(command: Command):
	get_tree().get_nodes_in_group("track")[command.track].add_command(command)
	
func play():
	get_tree().call_group("track", "play")

func pause():
	get_tree().call_group("track", "pause")
	
func stop():
	get_tree().call_group("track", "stop")

## Remove all commands
func clear():
	get_tree().call_group("track", "clear")

func remove_command(command: Command):
	get_tree().get_nodes_in_group("track")[command.track].remove_command(command)

func _on_track_command_added(command):
	emit_signal("command_added", command)
