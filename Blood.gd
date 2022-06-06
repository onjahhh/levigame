extends Node2D

var startFade = false


func _physics_process(delta):
	
	if startFade == true:
		set_modulate(lerp(get_modulate(), Color(1,1,1,0), 0.01))
		




func _on_Timer_timeout():
	$CPUParticles2D.set_process_internal(false)



func _on_Timer2_timeout():
	startFade = true
	$Timer3.start()

func _on_Timer3_timeout():
	queue_free()





