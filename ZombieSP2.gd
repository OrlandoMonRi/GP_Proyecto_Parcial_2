extends KinematicBody2D

const MOVE_SPEED = 100

var vida = 50

onready var raycast = $RayCast2D

var player = null

func _ready():
	add_to_group("zombies")

func _physics_process(delta):
	if player == null:
		return
	
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	global_rotation = atan2(vec_to_player.y, vec_to_player.x)
# warning-ignore:return_value_discarded
	move_and_collide(vec_to_player * MOVE_SPEED * delta)
	
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			vida = vida - 1
		if vida <= 0:
			coll.kill()
	
func kill():
	queue_free()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://FINAL.tscn")
func set_player(p):
	player = p
