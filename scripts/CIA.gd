extends KinematicBody2D

#onready var nav : Navigation2D = owner.get_node("NavMesh")
#onready var player = owner.get_node("Player")
#onready var deadBody = preload("res://scenes/CIA_BODY.tscn")
#
#
#var motion : Vector2
#var speed = 150
#var path = []
#var LKP : Vector2
#var dest :Vector2
#var dest_reached = false
#var threshold : float = 5.0
#var in_range = false
#var startPos : Vector2
#var state = IDLE
#var canShoot = true
#
#enum{
#	IDLE,
#	MOVE,
#	SHOOT,
#	RETURN,
#	MRAND,
#	DEAD,
#}
#
#func _physics_process(delta):
#
#	$deadbody.rotation = $body.rotation
#	if state != DEAD:
#		path = nav.get_simple_path(global_position , dest , true)
##		$Line2D.points = path
##		$Line2D.set_as_toplevel(true)
#		$HurtBox.rotation_degrees = $body.rotation_degrees
#		$legs.rotation_degrees = $body.rotation_degrees
#
#		$LOS.set_cast_to(player.global_position - global_position)
#		var seeing = $LOS.get_collider()
#		if seeing == player:
#			dest = player.global_position
#
#
#
#
#
#	match state:
#		IDLE:
#			_idle()
#		MOVE:
#			_move()
#		SHOOT:
#			_shoot()
#		RETURN:
#			pass
#		MRAND:
#			pass
#		DEAD:
#			_dead()
#
#
#
#
#
#
#
#func _idle():
#	$Animlegs.play("idle")
#	var seeing = $LOS.get_collider()
#	if seeing == player:
#		state = SHOOT
#
#func _move():
#	$body.look_at(dest)
#	var seeing = $LOS.get_collider()
#	if seeing == player:
#		state = SHOOT
#	else:
#		if path.size() > 1:
#			var dir2obj = global_position.direction_to(path[1])
#			motion = dir2obj * speed
#			move_and_slide(motion)
#			$Animlegs.play("walk")
#
#
#		if global_position == path[1]:
#			path.remove(0)
#
#		if global_position.distance_to(dest) < threshold and seeing != player:
#			state = IDLE
#		else:
#			state = MOVE
#
#
#func _shoot():
#	$body.look_at(dest)
#	var seeing = $LOS.get_collider()
#	$Animlegs.play("idle")
#	if seeing == player and canShoot == true:
#		canShoot = false
#		$ROF.start()
#	if seeing != player:
#		state = MOVE
#func _on_ROF_timeout():
#	canShoot = true
#
#func _on_HurtBox_area_entered(area):
#	state = DEAD
#
#func _dead():
#
#	var CDB = deadBody.instance()
#	CDB.rotation_degrees = $body.rotation_degrees
#	CDB.global_position = $body.global_position
#	var DNS = owner.get_node("DNS")
#
#	get_parent().add_child_below_node( DNS , CDB , true)
#	queue_free()
#
#
#
#
#
