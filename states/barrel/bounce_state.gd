extends State

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter(params: Dictionary = {}):
	super.enter(params)
	actor.velocity = Vector2(0, -150)
	actor.direction *= -1

func _process(_delta):
	anim_tree.set("parameters/StateMachine/Rolling/blend_position", actor.velocity.x)
	anim_tree.set("parameters/TimeScale/scale", actor.velocity.x / actor.SPEED)

func _physics_process(delta):
	actor.velocity.x = actor.direction * 0.6 * actor.SPEED
	actor.velocity.y += gravity * delta
	
	actor.move_and_slide()

	if actor.is_on_floor():
		transition_to.emit("Roll")
