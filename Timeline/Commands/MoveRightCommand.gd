extends Command

@export var target: Player

func run(_args: Array = []):
	target.move("right")


