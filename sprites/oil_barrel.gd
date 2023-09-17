extends Sprite2D

var flame_ball_scene = preload("res://sprites/flame_ball.tscn")
var frozen = false

@onready var anim_player = $AnimationPlayer as AnimationPlayer
@onready var ignite_timer = $IgniteTimer as Timer
@onready var initial_path = $"Initial Path" as Path2D

@export var flame_ball_parent: Node
@export var flame_ball_target: Node2D
@export var flame_ball_leap_speed = 100

func _physics_process(delta):
	if frozen:
		return

	for path_follow in initial_path.get_children():
		if not path_follow is PathFollow2D:
			continue

		path_follow.progress += flame_ball_leap_speed * delta

		if path_follow.progress_ratio == 1:
			_release_flame_ball(path_follow)

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

func _new_path_follow():
	var path_follow = PathFollow2D.new()
	path_follow.z_index = -10
	path_follow.rotates = false
	path_follow.cubic_interp = false
	path_follow.loop = false

	return path_follow

func _create_flame_ball():
	ignite()

	# Create a new flame ball
	var path_follow = _new_path_follow()
	var flame_ball = flame_ball_scene.instantiate() as Node2D
	flame_ball.target_node = flame_ball_target
	path_follow.add_child(flame_ball)
	initial_path.add_child(path_follow)

func _release_flame_ball(path_follow: PathFollow2D):
	# Move the flame ball to its navigational parent
	var flame_ball = path_follow.get_child(0) as Node2D
	var position = flame_ball.global_position
	path_follow.remove_child(flame_ball)
	flame_ball_parent.add_child(flame_ball)
	flame_ball.global_position = position
	flame_ball.start_following_paths()

	path_follow.queue_free()

func freeze(should_freeze: bool):
	frozen = should_freeze
