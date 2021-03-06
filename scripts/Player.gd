extends KinematicBody2D
onready var HUD = owner.get_node("CanvasLayer")
onready var tracerScene = preload("res://scenes/Tracer.tscn")
onready var impactScene = preload("res://scenes/Impact.tscn")


var setStartPoss : Vector2

var boltready = true

var speed = 200
var accel = 0.1
var motion = Vector2.ZERO
var can_fire = true
var dead = false
var hitloc : Vector2
var candash = true
var dashing = false

func _ready():
	pass

func _physics_process(delta):
	hitloc = $RayCast2D.get_collision_point()
	$HitPoint.global_position = hitloc
	print(str(motion))
	
	
	var cam_state = get_global_mouse_position()
	$Camera2D.offset_h = (cam_state.x - global_position.x) / (320 / 2.0)
	$Camera2D.offset_v = (cam_state.y - global_position.y) / (180 / 2.0)

	motion = move_and_slide(motion, Vector2.UP)
	get_input()
	_shoot()
	_recoil()
	
	
func get_input():
	if dead == false and dashing == false:
		look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("ui_up"):
		motion.y = lerp(motion.y , -speed , accel)
		
	elif Input.is_action_pressed("ui_down"):
		motion.y = lerp(motion.y , speed , accel)
	else:
		motion.y = lerp(motion.y , 0 , accel)
	if Input.is_action_pressed("ui_left"):
		motion.x = lerp(motion.x , -speed , accel)
		
	elif Input.is_action_pressed("ui_right"):
		motion.x = lerp(motion.x , speed , accel)
	else:
		motion.x = lerp(motion.x , 0 , accel)
	
	
	if Input.is_action_just_pressed("Shift"):
		
		
		if candash == true:
			look_at(-motion.normalized())
			speed *= 6
			dashing = true
			candash = false
			$dashtimer.start()
			
		



func _recoil():
	$Camera2D.position.x = clamp($Camera2D.position.x , -100, 0)
	var lookdir = get_global_mouse_position()

	$Camera2D.rotation_degrees = self.rotation_degrees
	#print(str($Camera2D.rotation_degrees))
	if boltready == false:
		$Camera2D.position.x = lerp($Camera2D.position.x , -25, 0.5)
	elif boltready == true:
		$Camera2D.position.x = lerp($Camera2D.position.x , 0, 0.5)


func _shoot():

	if Input.is_action_pressed("Fire") and boltready == true:
		boltready = false
		$Muzzle/MuzzleFlash.enabled = true
		
		
		
		var impact = impactScene.instance()
		var tracer = tracerScene.instance()
		
		impact.global_position = hitloc
		impact.look_at(self.global_position)
		
		
		tracer.startpos = $Muzzle.global_position
		tracer.endpos = $HitPoint.global_position
		
		owner.add_child(tracer)
		owner.add_child(impact)
		$cylce_timer.start()
	



func _on_cylce_timer_timeout():
	boltready = true
	$Muzzle/MuzzleFlash.enabled = false

func _on_dashtimer_timeout():
	candash = true
	dashing = false
	speed = 200



#also make the recoil effect with the camera, idk how we are gonna do that lmao

#also also, we gotta do the shit with the tracer so it doesnt look so jank, we know what we mean, just look at it...
#maybe make it so the alpha value decreses along the path of the line, once again, no idea how we are gotta do that.


