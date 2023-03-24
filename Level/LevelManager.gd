extends Node

@onready var game = get_node("/root/Game")
@onready var player = load("res://Player/Player.tscn")

func load():
	var current = get_node("/root/Game/Level")
	
	if current:
		current.name = "DyingWorld"
		current.queue_free()
		var current_player = game.get_node("Player")
		current_player.name = "DyingPlayer"
		current_player.queue_free()

	game.add_child(player.instantiate())
	var new_level = load("res://Level/Level%s.tscn" % GlobalData.level).instantiate()
	game.add_child(new_level)
	game.move_child(new_level, 0)
	
	game.get_node("Player").position = game.get_node("Level/PlayerSpawn").position
	game.get_node("Player").add_undo()
	
func prev():
	pass
