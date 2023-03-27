extends Node2D

@onready var timeline : Timeline = get_tree().get_nodes_in_group("timeline").pop_front()

var commands = {
	"up": preload("res://Timeline/Commands/MoveUpCommand.tscn"),
	"down": preload("res://Timeline/Commands/MoveDownCommand.tscn"),
	"left": preload("res://Timeline/Commands/MoveLeftCommand.tscn"),
	"right": preload("res://Timeline/Commands/MoveRightCommand.tscn"),
	"repeat": preload("res://Timeline/Commands/RepeatCommand.tscn"),
}

func _ready():
	
	if get_tree().get_nodes_in_group("timeline_command").size():
		return
	
	var new = commands["left"].instantiate()
	new.time = (0.5)
	new.track = 0
	timeline.add_command(new)
	
	new = commands["repeat"].instantiate()
	new.time = (1)
	new.track = 0
	timeline.add_command(new)
	
	new = commands["left"].instantiate()
	new.time = (1.5)
	new.track = 0
	timeline.add_command(new)
	
	new = commands["repeat"].instantiate()
	new.time = (2)
	new.track = 0
	timeline.add_command(new)
	
	new = commands["left"].instantiate()
	new.time = (2.5)
	new.track = 0
	timeline.add_command(new)
	
	new = commands["repeat"].instantiate()
	new.time = (3)
	new.track = 0
	timeline.add_command(new)
