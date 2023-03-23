extends Command

@export var target: Node2D

func run(_args: Array = []):
	var tween = get_tree().create_tween()
	tween.tween_property(
		target,
		"position",
		target.position + Vector2.RIGHT * 64,
		.5
	)


