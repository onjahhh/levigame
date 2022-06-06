extends RigidBody2D
var GBL_ROT
var GBL_POS : Vector2
var MAX_ROT
var MIN_ROT
func _physics_process(delta):
	pass

func _ready():
	GBL_POS = global_position
	GBL_ROT = rotation
	MIN_ROT = GBL_ROT - deg2rad(100)
	MAX_ROT = GBL_ROT + deg2rad(100)
func _integrate_forces(state):
	position = GBL_POS
	var new_rotation = clamp(rotation, MIN_ROT, MAX_ROT)
	var new_transform = Transform2D(new_rotation, position)
	state.transform = new_transform
	angular_damp = 15
	bounce = 1
	linear_velocity = Vector2.ZERO
	linear_damp = 0
