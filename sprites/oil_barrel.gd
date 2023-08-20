extends Sprite2D

signal did_ignite()

@onready var anim_player = $AnimationPlayer as AnimationPlayer
@onready var ignite_timer = $IgniteTimer as Timer

func ignite():
	if anim_player.current_animation == "ignite":
		return

	anim_player.play("ignite")
	ignite_timer.start()
	did_ignite.emit()

func _on_ignite_timer_timeout():
	anim_player.play("burn")

func _on_collision_area_body_entered(body):
	if body is Mario:
		body.kill()

func _on_collision_area_body_exited(body):
	if body is Barrel:
		if body.type == Barrel.Type.EXPLOSIVE:
			# Create a new flame ball
			print("Unimplemented: Create a FlameBall")

		body.queue_free()
