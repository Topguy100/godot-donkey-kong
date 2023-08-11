class_name BounceState extends State

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal finished_bounce

func on_enter():
	super.on_enter()
	actor.velocity = Vector2(0, -150)
	actor.direction *= -1

func _process(delta):
	anim_tree.set("parameters/StateMachine/Rolling/blend_position", actor.velocity.x)
	anim_tree.set("parameters/TimeScale/scale", actor.velocity.x / actor.SPEED)

func _physics_process(delta):
	actor.velocity.x = actor.direction * 0.6 * actor.SPEED
	actor.velocity.y += gravity * delta
	
	actor.move_and_slide()

	if actor.is_on_floor():
		finished_bounce.emit()
