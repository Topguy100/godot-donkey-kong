extends Sprite2D

var flame_ball_scene = preload("res://sprites/flame_ball.tscn")

@onready var anim_player = $AnimationPlayer as AnimationPlayer
@onready var ignite_timer = $IgniteTimer as Timer
@onready var flame_ball_spawn_location = $"Flame Ball Spawn Location" as Marker2D

@export var flame_ball_parent: Node

func ignite():
	if anim_player.current_animation == "ignite":
		return

	anim_player.play("ignite")
	ignite_timer.start()

func _on_ignite_timer_timeout():
	anim_player.play("burn")

func _on_collision_area_body_entered(body):
	if body is Mario:
		body.kill()

func _on_collision_area_body_exited(body):
	if body is Barrel:
		if body.type == Barrel.Type.EXPLOSIVE:
			_create_flame_ball()
		body.queue_free()

	if body.name == "ExplosiveBarrel":
		_create_flame_ball()
		body.queue_free()

func _create_flame_ball():
	# Create a new flame ball
	var flame_ball = flame_ball_scene.instantiate() as Node2D
	flame_ball.global_position = flame_ball_spawn_location.global_position
	flame_ball_parent.add_child(flame_ball)
	ignite()
