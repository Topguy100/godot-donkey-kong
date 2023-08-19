extends MarioState

const JUMP_VELOCITY = -290.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var should_skid := false

func enter(params: Dictionary = {}):
	super.enter(params)
	should_skid = mario.velocity.x != 0
	mario.velocity.y = JUMP_VELOCITY

func _physics_process(delta):
	mario.velocity.y += gravity * delta
	
	mario.move_and_slide()
	
	if mario.is_on_floor():
		transition_to.emit("Idle")
