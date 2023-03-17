class_name CrateTarget
extends Area2D

signal crate_placed
signal crate_removed

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("crate_placed", Callable(get_tree().root.get_node("/root/Game"), '_on_crate_placed'))
	connect("crate_removed", Callable(get_tree().root.get_node("/root/Game"), '_on_crate_removed'))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area is Crate:
		emit_signal("crate_placed", self, area)

func _on_area_exited(area):
	if area is Crate:
		emit_signal("crate_removed", self, area)
