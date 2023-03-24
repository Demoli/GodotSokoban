extends Node

@onready var game = get_node("/root/Game")
@onready var players := [
	load("res://Player/PlayerGreen.tscn"),
	load("res://Player/PlayerRed.tscn")
]

func load_level():
	var current = get_node("/root/Game/Level")
	
	if current:
		current.name = "DyingWorld"
		current.queue_free()
		for p in get_tree().get_nodes_in_group("player"):
			p.name = "DyingPlayer"
			p.queue_free()

	var new_level = load("res://Level/Level%s.tscn" % GlobalData.level).instantiate()
	game.add_child(new_level)
	game.move_child(new_level, 0)

	var player_spawns := [
		new_level.get_node("GreenPlayerSpawn"),
		new_level.get_node("RedPlayerSpawn"),
	]

	var p_index = 0
	for p_scene in players:
		var player = p_scene.instantiate()
		game.add_child(player)
		
		player.position = player_spawns[p_index].position
		p_index += 1
	
	
func prev():
	pass
