extends Node

@onready var game = get_node("/root/Game")
@onready var player = load("res://Player/Player.tscn")

func next():
	GlobalData.level += 1
	
	var level = load("res://Level/Level%s.tscn" % GlobalData.level)
	if GlobalData.level > 1:
		var current = get_node("/root/Game/Level")
		current.name = "DyingWorld"
		current.queue_free()
		var current_player = game.get_node("Player")
		current_player.name = "DyingPlayer"
		current_player.queue_free()

	var new_level = level.instantiate()
	game.add_child(new_level)
	game.move_child(new_level, 0)
	game.add_child(player.instantiate())
	
	game.get_node("Player").position = game.get_node("Level/PlayerSpawn").position
	game.get_node("Player").add_undo()
	
func prev():
	pass

func new_game():
	GlobalData.level = 0
	next()
