extends State

const ACCEL_X = 1000

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(_delta):
	anim_tree.set("parameters/StateMachine/Rolling/blend_position", actor.velocity.x)
	anim_tree.set("parameters/TimeScale/scale", absf(actor.velocity.x / actor.SPEED))

func _physics_process(delta):
	actor.velocity.x = move_toward(actor.velocity.x, actor.SPEED * actor.direction * 0.3, ACCEL_X * delta)
	actor.velocity.y += gravity * delta

	actor.move_and_slide()

	if actor.is_on_floor():
		transition_to.emit("Bounce")
