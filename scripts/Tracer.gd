extends Node2D

var startpos
var endpos
var noSee = false
var tracerOptions = [0,1,2]
var tracerChoose


func _ready():
	$Line2D.default_color.a = 1
	tracerOptions.shuffle()
	tracerChoose = tracerOptions.front()
	$Line2D.points = [startpos , endpos]
	
func _process(delta):
#	print(str($Line2D.default_color.a))
	if tracerChoose == 0:
		$Line2D.default_color.a = clamp($Line2D.default_color.a , 0 , 1)
		if $Line2D.default_color.a != 0:
			$Line2D.default_color.a -= 0.01
		elif $Line2D.default_color.a == 0:
			queue_free()
	
	elif tracerChoose == 1 or 2:
		$Line2D.default_color.a = 0




