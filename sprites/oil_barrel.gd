extends Sprite2D

@onready var anim_player = $AnimationPlayer as AnimationPlayer
@onready var ignite_timer = $IgniteTimer as Timer

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
			_create_flameball()
		body.queue_free()

	if body.name == "ExplosiveBarrel":
		_create_flameball()
		body.queue_free()

func _create_flameball():
	# Create a new flame ball
	print("Unimplemented: Create a FlameBall")
	ignite()
