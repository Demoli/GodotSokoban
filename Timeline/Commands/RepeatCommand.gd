extends Command

@export var target: Player

@export var repeat := 1

func run(_args: Array = []):
	pass


func _physics_process(delta):
	super(delta)
	if Input.is_action_just_pressed("command_repeat_increase"):
		repeat += 1
	if Input.is_action_just_pressed("command_repeat_decrease"):
		repeat -= 1
	$Label.text = str(repeat)
