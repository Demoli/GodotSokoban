extends Node2D


const SPEED = 300
var direction = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("right"):
		$Player.position.x += SPEED * delta
	if Input.is_action_pressed("left"):
		$Player.position.x -= SPEED * delta


func _on_player_area_entered(area):
	print("Player detected %s" % area.name)


func _on_player_area_exited(area):
	print("Player stopped detecting %s" % area.name)


func _on_target_area_entered(area):
	print("Target detected %s" % area.name)


func _on_target_area_exited(area):
	print("Target stopped detecting %s" % area.name)
