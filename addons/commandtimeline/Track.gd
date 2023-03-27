class_name Track
extends GridContainer

signal command_added

## Tick speed in seconds
@export var tick_speed: float = 1

@export var playing: bool = false

@export var commands_per_track := 64
		
## How many commands can be executed in 1 tick.[br]
##e.g. a tick of 1 and step of 1 will execute the first command at 1 second, the next at 2 seconds.[br]
##A tick of 1 and a step of 2 will execute the first command at 0.5 seconds, the next at 1 second, and so on
@export var command_step: float = .5

## If true you can place a command at zero seconds, then the rest willow follow the command step
@export var allow_command_at_zero := false

@export var placeholder: PackedScene

@export var track_index := 0

var commands: Array = []
var tick: float = 0.0
var time_start: float

func _ready():
	add_to_group("track")
	_init_placeholders()	

func _get_configuration_warnings():
	if not placeholder:
		return ["A timline needs a CommandPlaceholder node, this is used to position commands"]

func _unhandled_key_input(event):
	if event.is_action_pressed("play_pause"):
		if not playing:
			play()
		else:
			pause()
	if event.is_action_pressed("stop"):
		stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing:
		tick += tick_speed * delta
		_process_commands()

func _process_commands():
	var runnable = commands.filter(
		func(command): 
			var time = snapped(tick, command_step)
			if command.time == time and not command.has_run:
				return true
	)
	
	if runnable.size():
		for c in runnable:
			c.run()
			c.has_run = true

func play():
	playing = true

func pause():
	playing = false
	
func stop():
	pause()
	tick = 0
	for c in commands:
		c.reset()
	
func get_running_time():
	var time_now = Time.get_unix_time_from_system()
	var time_elapsed = time_now - time_start
	
	return time_elapsed

func add_command(command: Command):
	commands.append(command)
	var place = get_command_placeholder(command)
	command.position = Vector2(place.get_rect().size.x / 2, place.get_rect().size.y / 2)
	place.add_child(command)
	
	emit_signal("command_added", command)

func remove_command(command: Command):
	commands.erase(command)			

func get_command_placeholder(command: Command):
	return get_children().filter(
		func(place):
			if place is CommandPlaceholder:
				return place.time_position == command.time
			return false
	).pop_front()

func _init_placeholders():
	
	var start = 0 if allow_command_at_zero else 1
	
	for time in range(start, commands_per_track):
		var new_place = placeholder.instantiate()
		new_place.time_position = (time * command_step)
		new_place.track = track_index
		add_child(new_place)

func clear():
	for c in commands:
		c.queue_free()
	commands = []
