extends Node2D

onready var enemy = preload("res://scenes/Enemy.tscn")
onready var pos = $Position2D.global_position



func _ready():
	randomize()
	$Timer.wait_time = rand_range(1,6)
	$Timer.start()

func _spawn():
	print(str($Timer.wait_time))
	if Stats.enemyCount != Stats.enemyLimit:
		$Timer.wait_time = rand_range(1,6)
		Stats.enemyCount += 1
		var spawnEnemy = enemy.instance()
		spawnEnemy.global_position = pos
		owner.add_child(spawnEnemy)
	
	elif Stats.enemyCount == Stats.enemyLimit:
		queue_free()

func _on_Timer_timeout():
	_spawn()
