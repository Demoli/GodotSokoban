class_name RepeatCommand
extends Command

@export var target: Player

@export var repeat := 1

var starting_repeat: int

func _ready():
	super()
	starting_repeat = repeat

func run():
	super()
	var owning_track: Track = get_tree().get_nodes_in_group("track")[track]
	
	if repeat > 0:
		var commands: Array = owning_track.commands
		var current_repeat = commands.find(self)
		var previous_repeat = _find_previous_repeat(owning_track, current_repeat)
		var to_repeat = commands.slice(previous_repeat, current_repeat)
		var new_tick = to_repeat[0].time
		
		owning_track.tick = new_tick
		
		repeat -= 1
		has_run = false
		for c in to_repeat:
			c.has_run = false
	else:
		## This command has stopped repating and so takes no time
		owning_track.tick += owning_track.command_step
	
func reset():
	super()
	repeat = starting_repeat

func _physics_process(delta):
	super(delta)
	if Input.is_action_just_pressed("command_repeat_increase"):
		repeat += 1
	if Input.is_action_just_pressed("command_repeat_decrease"):
		repeat -= 1
	$Label.text = str(repeat)

func _find_previous_repeat(owning_track: Track, current_index: int):
	var previous = owning_track.commands.slice(0, current_index).filter(func(c): return c is RepeatCommand).pop_back()
	return owning_track.commands.find(previous) + 1 if previous else 0
