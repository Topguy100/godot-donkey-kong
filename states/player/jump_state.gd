extends PlayerState

const JUMP_VELOCITY = -290.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var should_skid := false

func enter(params: Dictionary = {}):
	super.enter(params)
	should_skid = player.velocity.x != 0
	player.velocity.y = JUMP_VELOCITY

func _physics_process(delta):
	player.velocity.y += gravity * delta
	
	player.move_and_slide()
	
	if player.is_on_floor():
		transition_to.emit("Idle")
