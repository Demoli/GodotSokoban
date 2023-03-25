extends Area2D

@export var crate := preload("res://Crates/Crate.tscn")

func _ready():
	spawn()

func spawn():
	var new = crate.instantiate()
	new.set_position(position)
	get_parent().add_child.call_deferred(new)
