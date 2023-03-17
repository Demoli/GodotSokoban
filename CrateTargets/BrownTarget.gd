class_name CrateTarget
extends Area2D

signal crate_placed

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("crate_placed", Callable(get_tree().root.get_node("/root/Game"), '_on_crate_placed'))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area is Crate:
		emit_signal("crate_placed", self, area)
