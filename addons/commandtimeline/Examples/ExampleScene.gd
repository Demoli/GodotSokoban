extends Node

@onready var move_right_com = load("res://addons/commandtimeline/Examples/ExampleCommands/MoveRightCommand.tscn")

func _ready():
	var new = move_right_com.instantiate()
	new.time = .5
	new.target = $Player
	$Timeline.add_command(new)
	
	new = move_right_com.instantiate()
	new.target = $Player
	new.time = 1.0
	$Timeline.add_command(new)
	
#	new = move_right_com.instantiate()
#	new.target = $PlayerRed
#	new.time = 1
#	new.track = 1
#	$Timeline.add_command(new)


func _on_timeline_command_added(command: Command):
	match command.track:
		0: command.target = $Player
		1: command.target = $PlayerRed
