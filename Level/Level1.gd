extends Node2D

@onready var timeline : Timeline = get_tree().get_nodes_in_group("timeline").pop_front()

var commands = {
	"up": preload("res://Timeline/Commands/MoveUpCommand.tscn"),
	"down": preload("res://Timeline/Commands/MoveDownCommand.tscn"),
	"left": preload("res://Timeline/Commands/MoveLeftCommand.tscn"),
	"right": preload("res://Timeline/Commands/MoveRightCommand.tscn"),
}

func _ready():
	for track in range(0,2):
		print(track)
		for i in 4:
			var new = commands["down"].instantiate()
			new.time = (0.5 * i)
			new.track = track
			timeline.add_command(new)
		for i in 4:
			var new = commands["up"].instantiate()
			new.time = 2 + (0.5 * i)
			new.track = track
			timeline.add_command(new)

		var new = commands["right"].instantiate()
		new.time = 4
		new.track = track
		timeline.add_command(new)
		for i in 4:
			new = commands["down"].instantiate()
			new.time = 4.5 + (0.5 * i)
			new.track = track
			timeline.add_command(new)
