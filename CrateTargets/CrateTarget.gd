extends Area2D

signal crate_placed
signal crate_removed

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("crate_removed", Callable(get_tree().root.get_node("/root/Game"), '_on_crate_removed'))
	connect("crate_placed", Callable(get_tree().root.get_node("/root/Game"), '_on_crate_placed'))


func _on_area_entered(area):
	if area is Crate:
		emit_signal("crate_placed", self, area)


func _on_area_exited(area):
	if area is Crate:
		emit_signal("crate_removed", self, area)
