@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Timeline", "Node2D", preload("res://addons/commandtimeline/Timeline.gd"), preload("res://addons/commandtimeline/icon.png"))
	add_custom_type("Command", "Node2D", preload("res://addons/commandtimeline/Command.gd"), preload("res://addons/commandtimeline/icon.png"))
	add_custom_type("CommandPlaceholder", "Node2D", preload("res://addons/commandtimeline/CommandPlaceholder.gd"), preload("res://addons/commandtimeline/icon.png"))
	add_custom_type("CommandPalette", "Control", preload("res://addons/commandtimeline/CommandPalette.gd"), preload("res://addons/commandtimeline/icon.png"))
	add_custom_type("CommandButton", "Control", preload("res://addons/commandtimeline/CommandButton.gd"), preload("res://addons/commandtimeline/icon.png"))


func _exit_tree():
	# Clean-up of the plugin goes here.
	pass
