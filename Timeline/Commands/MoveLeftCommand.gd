extends Command

@export var target: Player

func run():
	super()
	target.move("left")


