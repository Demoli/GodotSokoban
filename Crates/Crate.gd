class_name Crate
extends Area2D

@onready var ray: RayCast2D = $RayCast2D

var animation_speed = 12
var moving = false
var tile_size = 64
var directions = {
	"up": Vector2.UP,
	"right": Vector2.RIGHT,
	"down": Vector2.DOWN,
	"left": Vector2.LEFT,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$Undoer.save_state({"position":position})
	pass # Replace with function body.

func _input(_event):
	if Input.is_action_just_pressed("undo"):
		if is_touching_player():
			$Undoer.undo()

	if Input.is_action_just_pressed("redo"):
		if is_touching_player():
			$Undoer.redo()
	

func is_pushable(dir):
	ray.target_position = directions[dir] * tile_size
	ray.force_raycast_update()
	return !ray.is_colliding()

func push(dir: String):
	if is_pushable(dir):
		
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + directions[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
		add_undo()
		
		return true
	
	return false

func is_touching_player():
	for dir in directions:
		ray.target_position = directions[dir] * tile_size
		ray.force_raycast_update()
		if ray.get_collider() is Player:
			return true
	
	return false

func add_undo():
	$Undoer.save_state({"position":position})
