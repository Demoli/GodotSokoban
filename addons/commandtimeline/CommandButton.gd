class_name CommandButton
extends TextureButton

@export var command: PackedScene

func _get_configuration_warnings():
	if not command:
		return ["This node needs a Command node to instantiate on press, please set a PackedScene on the Command property"]

func _ready():
	connect("pressed", Callable(self, "_on_pressed"))

func _on_pressed():
	var new = command.instantiate() as Command
	new.position = get_global_mouse_position()
	new.draggable = true
	get_tree().root.add_child(new)
