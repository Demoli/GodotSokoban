class_name Crate
extends Area2D

@onready var ray: RayCast2D = $RayCast2D

var animation_speed = 12
var moving = false
var tile_size = 64
var directions = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_pushable(dir):
	ray.target_position = directions[dir] * tile_size
	ray.force_raycast_update()
	var is_target = ray.get_collider() is CrateTarget

	return !ray.is_colliding() or is_target
	

func push(dir: String):
	if is_pushable(dir):
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + directions[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		$AnimationPlayer.play(dir)
		await tween.finished
		moving = false
		
		return true
	return false
