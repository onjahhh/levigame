extends Node2D

onready var Env = preload("res://scenes/Env.tscn")

func _ready():
	get_node("/root/BackDoor").add_child(Timer,true)



func _physics_process(delta):
	
	Engine.set_target_fps(Engine.get_iterations_per_second())
	
