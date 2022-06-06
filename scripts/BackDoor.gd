extends Node2D


func _physics_process(delta):
	Engine.set_target_fps(Engine.get_iterations_per_second())


