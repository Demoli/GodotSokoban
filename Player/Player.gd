class_name Player
extends Area2D

var animation_speed = 12
var moving = false
var tile_size = 64
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}
var has_undone = false
	
@onready var ray: RayCast2D = $RayCast2D

func _ready():
	add_to_group("player")
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2

func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)


func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	
	var can_move = !ray.is_colliding()
	
	if ray.is_colliding():
		var c = ray.get_collider()
		if c:
			if c is Crate and c.is_pushable(dir):
				c.push(dir)
				can_move = true
	
	if can_move:
		if has_undone:
			get_parent().clear_undo()
			has_undone = false

		$AnimatedSprite2D.play(dir)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		$AnimatedSprite2D.stop()
		moving = false
