extends KinematicBody2D

onready var nav : Navigation2D = get_node("/root/env")
onready var player = get_node("/root/Env/Player")
onready var level = get_node("/root/Env")
onready var path = []
onready var hitDetect = player.get_node("RayCast2D")
onready var blood = preload("res://scenes/Blood.tscn")
onready var aggroRange = $AggroDetectZone

#signal stateChanged(newState)

var motion :Vector2
var speed = 100
var pos = self.global_position
var dead = false
var HP = 100
var hitpos : Vector2
#var currentState: int = state.PATROL setget set_state
var currentState = PATROL

enum{
	PATROL,
	ENGAGE,
}

func _ready():
	if currentState == PATROL:
		print("omfg")


func __physics_process(delta):
	
	pos = position
	path = nav.get_simple_path(pos,player.position)
	$Line2D.points = path
	$Line2D.set_as_toplevel(true)
	## DEBUG: Used to see enemy pathing
	
	motion = position.direction_to(path[1]) * speed
	move_and_slide(motion)
	
	if position == path[1]:
		path.remove(0)
	
	match currentState:
		PATROL:
			print("BROOOO")
			_PATROL()
		ENGAGE:
			_engage()
			



#func set_state(newState: int):
#	if newState == currentState:
#		return
		
	
#	currentState = newState
#	emit_signal("stateChanged", currentState)


func _PATROL():
	print("nigga")

func _engage():
	print("pog")


func _dead_check():
	if HP <=0:
		queue_free()


func _on_HurtBox_area_entered(area):
	if area.is_in_group("Hitzone"):
		var bloodInstance = blood.instance()
		hitpos = global_position
	
		bloodInstance.global_position = hitpos
		bloodInstance.look_at(player.global_position)
	
		level.add_child(bloodInstance)
	
		HP -= 20
		_dead_check()







func _on_AggroDetectZone_body_entered(body):
	print("yup")
	if body.is_in_group("Player"):
		print("BRUH")
		currentState = ENGAGE

