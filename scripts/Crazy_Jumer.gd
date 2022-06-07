extends KinematicBody2D



onready var nav : Navigation2D = get_node("/Env/NavMesh")
onready var path = []
onready var player = get_node("/root/Env/Player")


var pos = position
var motion = Vector2.ZERO
var speed = 100
var motionLerp = 0.1
var pounceInRange 

var state = IDLE

enum{
	IDLE,
	CHASE,
	POUNCE,
}

func _physics_process(_delta):
	
	
	
	move_and_slide(motion,Vector2.UP)
	
	match state:
		IDLE:
			_idle()
		CHASE:
			_chase()
		POUNCE:
			_pounce()


func _idle():
	pass

func _chase():
	pos = position
	#path = nav.get_simple_path(pos,player.position)
	#$Line2D.points = path
	#$Line2D.set_as_toplevel(true)
	## DEBUG: Used to see enemy pathing
	
	motion = position.direction_to(path[1]) * speed
	move_and_slide(motion)
	
	if position == path[1]:
		path.remove(0)

func _pounce():
	pass










